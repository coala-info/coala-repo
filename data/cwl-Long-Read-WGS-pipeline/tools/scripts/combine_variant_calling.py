import os, sys, gzip, logging

def judge_variants(clair_vcf, freebayes_vcf, out_vcf,
                   flagged_regions, af_cut_off=0.9):
    """take clair and freebayes vcf and judge each variant, real vars are: PASS

    :param clair_vcf: str, filtered vcf
    :param freebayes_vcf: str, filtered vcf
    :param report: str, created report file, with the decision for each variant
    :param out_vcf: str, created vcf file with variants labeled as 'real'
    :param flagged_regions: dict, keys: chr names (in ref), list of tuples
    with regions that are flagged
    :param af_cut_off: flt, default=0.9, defines the minimum allele frequency
    (AF) in the clair_vcf, to classify a var as 'real'
    :return:
    """
    # initialise list to store all lines of the output vcf file
    vars_report_list = []
    # convert both input vcf files into dicts
    clair3_dict = convert_vcf_to_dict(clair_vcf)
    freeb_dict = convert_vcf_to_dict(freebayes_vcf)
    # take the union of the keys of both dicts (so that all positions are
    # evaluated)
    all_chroms = clair3_dict.keys() | freeb_dict.keys()

    for chrom in sorted(list(all_chroms)):
        # build here a decision tree how to classify each var

        # try whether the chromosome is present in both the clair3 and
        # freebayes data
        try:
            all_vars = clair3_dict[chrom].keys() | freeb_dict[chrom].keys()
            clair3_chrom_dict = clair3_dict[chrom]
            freeb_chrom_dict = freeb_dict[chrom]
        except KeyError:
            # the chrom is either not present in the clair3 or in the
            # freebayes dict.
            if chrom not in clair3_dict:
                # the clair3 data does not cover this chrom, only evaluate
                # freebayes vars, and define clair3 data as empty dict
                all_vars = freeb_dict[chrom]
                freeb_chrom_dict = freeb_dict[chrom]
                clair3_chrom_dict = {}
            else:
                # the freebayes data does not cover this chrom, only evaluate
                # clair3 vars, and define freeb data as empty dict
                all_vars = clair3_dict[chrom]
                clair3_chrom_dict = clair3_dict[chrom]
                freeb_chrom_dict = {}
        # sort the keys so that the variants are handled in a logical order
        sorted_vars = sorted(list(all_vars))
        # if there is a flagged region for the chromosome we are processing
        # now: define this
        flag_regions_list = []
        if chrom in flagged_regions:
            flag_regions_list = flagged_regions[chrom]
        # loop through each var (position)
        for var in sorted_vars:
            # call function to handle the var
            status, new_vcf_elem = classify_single_var(var, clair3_chrom_dict,
                                                 freeb_chrom_dict, af_cut_off)
            # look whether the var is in a flagged region
            if flag_regions_list:
                for left_bound, right_bound in flag_regions_list:
                    if left_bound <= var <= right_bound:
                        flagged_region = f"{chrom}:{left_bound}-{right_bound}"
                        # update the INFO column with the flagged region
                        new_vcf_elem[7] = f"FR={flagged_region}" \
                                          f",{new_vcf_elem[7]}"
            if len(new_vcf_elem) == 10:
                vars_report_list.append(new_vcf_elem)
            elif len(new_vcf_elem) == 2:
                vars_report_list.append(new_vcf_elem[0])
                vars_report_list.append(new_vcf_elem[1])
    report_vars_to_vcf(out_vcf, vars_report_list, clair_vcf, freebayes_vcf)
    return None

# helper functions

def report_vars_to_vcf(out_vcf, var_list, clair_vcf, freeb_vcf):
    """take a list of (classified) variants and write to vcf format output

    :param out_vcf: str, path a .vcf file
    :param var_list: list of lists, each lists represents one variants and
    contains all the columns of a vcf file
    :return: None
    """
    if clair_vcf.endswith('.gz'):
        clair_vcf = gzip.open(clair_vcf, 'rt')
    else:
        clair_vcf = open(clair_vcf, 'rt')
    freeb_vcf = open(freeb_vcf, 'r')
    clair_header_lines = []
    freeb_header_lines = []
    for line in clair_vcf:
        if not line.startswith("#"):
            break
        line = line.strip()
        clair_header_lines.append(line)
    for line in freeb_vcf:
        if not line.startswith("#"):
            break
        line = line.strip()
        freeb_header_lines.append(line)
    clair_vcf.close()
    freeb_vcf.close()

    header_dict = {'Filter': [], 'Info': [], 'Contig': [], 'Format':[]}
    for header_set in [clair_header_lines, freeb_header_lines]:
        for line in header_set:
            if line.startswith("##FILTER="):
                header_dict['Filter'].append(line)
            elif line.startswith('##INFO'):
                header_dict['Info'].append(line)
            elif line.startswith('##FORMAT'):
                header_dict['Format'].append(line)
            elif line.startswith('##contig'):
                header_dict['Contig'].append(line)
            else:
                pass
    # add custom lines to the dict
    header_dict = add_custom_vcf_header_lines(header_dict)

    with open(out_vcf, 'w') as out_f:
        out_f.write("##fileformat=VCFv4.2\n")
        # write contig info:
        unique_contigs = list(set(header_dict['Contig']))
        for line in unique_contigs:
            out_f.write(line + '\n')
        # write filter info
        for line in header_dict['Filter']:
            out_f.write(line + '\n')
        # write Info info
        for line in header_dict['Info']:
            out_f.write(line + '\n')
        # write format info
        for line in header_dict['Format']:
            out_f.write(line + '\n')

        # write the column headers
        out_f.write("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT"
                    "\tsample\n")
        # add the variants
        for var_elem in var_list:
            new_line = '\t'.join(var_elem)
            out_f.write(new_line + '\n')
    return None


def classify_single_var(pos, clair_var_dict, freeb_var_dict, af_cut_off,
                        filter_list=['SoftMasked', 'V0_var', 'LowQual',
                                     'RefCall']):
    """for one variant, determine status/filter name

    :param pos: int, position of the variant
    :param clair_var_dict: dict with keys (int) pos of vars, values: line
    elements of vcf file, source of dict is a bam file with reads
    :param freeb_var_dict: dict with keys (int) pos of vars, values: line
    elements of vcf file, source of dict is a bam file with a mapped assembly
    :param af_cut_off: float, cut off for allele frequency score
    :param filter_list: list of str, list with filter options that can be
    ignored by this function

    :return: status: str, sentence of explanation what decision is made
            out_vcf_elem: list of str, updated elements of the variants (thus
            filter column is updated by the classfication).
    """
    # check whether the position is confirmed by both variant callers
    if pos in clair_var_dict and pos in freeb_var_dict:
        vcf_elem_clair3 = clair_var_dict[pos]
        vcf_elem_freeb = freeb_var_dict[pos]

        # check whether this var has been assigned to another filter already,
        # if yes, then do nothing
        if vcf_elem_clair3[6] in filter_list:
            out_vcf_elem = vcf_elem_clair3.copy()
            status = 'Previously filtered variant'
        elif vcf_elem_freeb[6] in filter_list:
            out_vcf_elem = freeb_var_dict.copy()
            status = 'Previously filtered variant'
        else:
            # check whether the ref and alt alleles are the same!
            if vcf_elem_clair3[3] != vcf_elem_freeb[3] and len(vcf_elem_clair3[4]) - len(vcf_elem_clair3[3]) != len(vcf_elem_freeb[4]) - len(vcf_elem_freeb[3]):
                #REF annotation is not the same, create two separate elements to add to the vcf file
                out_vcf_elem_1 = vcf_elem_clair3.copy()
                allele_freq_score = get_af_score(vcf_elem_clair3)
                if allele_freq_score > af_cut_off:
                    status = "REAL"
                    out_vcf_elem_1[6] = 'PASS'
                else:
                    status = "Var confirmed by both clair and freebayes"
                    out_vcf_elem_1[6] = 'Both_Low_AF'
                out_vcf_elem_2 = vcf_elem_freeb.copy()
                out_vcf_elem_2[6] = 'Freeb_call'
                out_vcf_elem = [out_vcf_elem_1, out_vcf_elem_2]
            elif vcf_elem_clair3[4] != vcf_elem_freeb[4] and len(vcf_elem_clair3[4]) - len(vcf_elem_clair3[3]) != len(vcf_elem_freeb[4]) - len(vcf_elem_freeb[3]):
                #ALT annotation is not the same, add the alt from Freebayes to the clair3 vcf info with comma's as a second variant
                allele_freq_score = get_af_score(vcf_elem_clair3)
                if allele_freq_score > af_cut_off:
                    status = "REAL"
                    vcf_elem_clair3[6] = 'PASS'
                else:
                    status = "Var only confirmed by clair3, with low AF " \
                             "score"
                    vcf_elem_clair3[6] = 'Clair_Low_AF'
                vcf_elem_freeb[6] = 'Freeb_call'

                out_vcf_elem = []
                elem_idx = 0
                for elem_clair, elem_freeb in zip(vcf_elem_clair3, vcf_elem_freeb):
                    if elem_idx < 3:
                        out_vcf_elem.append(elem_clair)
                    else:
                        out_vcf_elem.append(f"{elem_clair},{elem_freeb}")
                    elem_idx += 1
            else:
                out_vcf_elem = vcf_elem_clair3.copy()
                # get AF score of clair3
                allele_freq_score = get_af_score(vcf_elem_clair3)
                if allele_freq_score > af_cut_off:
                    status = "REAL"
                    # after setting the status: each time update the filter
                    # column of the vcf file
                    out_vcf_elem[6] = 'PASS'
                else:
                    # could check whether clair3 and freeb also report the
                    #  same var based on the ref and alt columns
                    # BUT: I think the chance of them reporting a different
                    # variant on exactly the same position is small --> because
                    # they are based on the same input data
                    status = 'Variant called by both clair3 and ' \
                                'Freebayes, but low AF-score: non-reliable'
                    out_vcf_elem[6] = 'Both_Low_AF'
    elif pos in clair_var_dict:
        vcf_elem_clair3 = clair_var_dict[pos]
        out_vcf_elem = vcf_elem_clair3.copy()
        # do nothing if Filter is in filter_list
        if vcf_elem_clair3[6] in filter_list:
            status = 'Previously filtered variant'
        else:
            allele_freq_score = get_af_score(vcf_elem_clair3)
            if allele_freq_score > af_cut_off:
                status = "Var only confirmed by clair3, with high AF " \
                         "score"
                out_vcf_elem[6] = 'Clair_High_AF'
            else:
                status = "Var only confirmed by clair3, with low AF " \
                         "score"
                out_vcf_elem[6] = 'Clair_Low_AF'
    elif pos in freeb_var_dict:
        vcf_elem_freeb = freeb_var_dict[pos]
        out_vcf_elem = vcf_elem_freeb.copy()
        if vcf_elem_freeb[6] in filter_list:
            status = 'Previously filtered variant'
        else:
            status = "Var only confirmed by freebayes"
            out_vcf_elem[6] = 'Freeb_call'
    else:
        logging.error('This should not happen, pos was not either clair3 or '
                      'freebayes vcf files')
    return status, out_vcf_elem


def convert_vcf_to_dict(in_vcf):
    """convert vcf file to dict based on the POS column

    :param in_vcf: str, vcf file
    :return: vcf_dict: dict, key (int, position of var), value: list of str,
    column of the vcf file for that line
    """
    vcf_dict = {}
    if in_vcf.endswith('.gz'):
        in_f = gzip.open(in_vcf, 'rt')
    else:
        in_f = open(in_vcf, 'r')
    for line in in_f:
        line = line.strip()
        if line.startswith('#'):
            continue
        line_elem = line.split('\t')
        chrom = line_elem[0]
        if chrom not in vcf_dict:
            vcf_dict[chrom] = {}
        pos = int(line_elem[1])
        vcf_dict[chrom][pos] = line_elem
    in_f.close()
    return vcf_dict
	

def get_af_score(vcf_line, sample_column=9):
    """take input from vcf file and extract AF score

    :param vcf_line: list of str, containing all the elements of a line in a
    vcf file
    :param sample_column: int, position of the relevant sample column in the
    vcf file, can be changed for a multi-sample vcf file
    :return: af_score: float
    """
    format_col, sample_col = vcf_line[8], vcf_line[sample_column]
    format_elem, sample_elem = format_col.split(':'), sample_col.split(':')
    # find the index of the AF attribute
    try:
        af_idx = format_elem.index('AF')
    except ValueError:
        logging.error('The vcf input passed to get_af_score does not contain '
                      'an AF attribute in FORMAT')
        return 0
    # workaround for multi-allelic VCF records
    try:
        af_score = float(sample_elem[af_idx])
    except ValueError:
        # Multi-allelic site, split and take first allele's AF
        af_score = float(sample_elem[af_idx].split(',')[0])
    return af_score
	

def add_custom_vcf_header_lines(header_dict):
    """

    :param header_dict:
    :return:
    """
    header_dict['Filter'].append('##FILTER=<ID=Clair_High_AF,'
                                 'Description="Variant only confirmed by '
                                 'clair3 with a high AF score">')
    header_dict['Filter'].append('##FILTER=<ID=Clair_Low_AF,'
                                 'Description="Variant only confirmed by '
                                 'clair3 with a low AF score">')
    header_dict['Filter'].append('##FILTER=<ID=Both_Low_AF,'
                                 'Description="Variant called by both clair3 '
                                 'and Freebayes but low AF-score">')
    header_dict['Filter'].append('##FILTER=<ID=Freeb_call,'
                                 'Description="Variant only confirmed by '
                                 'Freebayes">')
    header_dict['Filter'].append('##FILTER=<ID=SoftMasked,'
                                 'Description="Variant in '
                                 'unreliable region of the reference">')
    header_dict['Filter'].append('##FILTER=<ID=V0_var,Description="Variant '
                                 'already present in the WT assembly">')
    header_dict['Info'].append('##INFO=<ID=FR,Number=.,Type=String,'
                               'Description="Specifies whether the variant is '
                               'part of a flagged region">')
    header_dict['Info'].append('##INFO=<ID=ref_chrom,Number=1,Type=String,'
                               'Description="Name of the ref chrom">')
    header_dict['Info'].append('##INFO=<ID=ref_pos,Number=1,Type=Integer,'
                               'Description="Position of var on the ref '
                               'chrom">')
    return header_dict

def main():
    if len(sys.argv) < 2:
        print("Usage: python combine_variantcalling.py <clair3_vcf> <freebayes_vcf> ")
        sys.exit(1)

    clair3_vcf = sys.argv[1]
    freebayes_vcf = sys.argv[2]

    judge_variants(clair3_vcf, freebayes_vcf, "combined_output.vcf", {})

if __name__ == "__main__":
    main()