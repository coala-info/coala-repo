# degenotate CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| degenotate | PASS | Rewritten from help (old file used invented flags and a missing command); repo test data: multi-cds.fa gives correct per-site degeneracy, corBra VCF gives an MK table for 988 transcripts. |

## degenotate

### Tool Description
A tool to annotate degeneracy (0-fold, 2-fold, 3-fold, and 4-fold sites) in a genome given an annotation and a genome file.

### Metadata
- **Docker Image**: quay.io/biocontainers/degenotate:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/harvardinformatics/degenotate
- **Package**: https://anaconda.org/channels/bioconda/packages/degenotate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/degenotate/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/harvardinformatics/degenotate
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/degenotate.py -h

#
# =============================================================================================================================
                                                                                      
    |                               |           |             
,---| ,---. ,---. ,---. ,---. ,---. |---  ,---. |---  ,---.
|   | |---' |   | |---' |   | |   | |     ,---| |     |---'
`---' `---' `---| `---' `   ' `---' `---' `---^ `---' `---'
            `---'                                                               
usage: degenotate.py [-h] [-a ANNOTATION_FILE] [-g GENOME_FILE] [-s IN_SEQ]
                     [-v VCF_FILE] [-u VCF_OUTGROUPS] [-e VCF_EXCLUDE]
                     [-o OUT_DEST] [-sfs] [-d SEQ_DELIM] [-c [WRITE_CDS]]
                     [-ca [WRITE_CDS_AA]] [-l [WRITE_LONGEST]]
                     [-la [WRITE_LONGEST_AA]] [-x EXTRACT_SEQ] [-m MIN_LENGTH]
                     [-maf MAF_CUTOFF] [-imp IMP_CUTOFF] [--no-fixed-in]
                     [--overwrite] [--appendlog] [--info] [--version]
                     [--quiet]

degenotate: Annotation of codon degeneracy for coding sequences

options:
  -h, --help            show this help message and exit
  -a ANNOTATION_FILE    A gff or gtf file that contains the coordinates of
                        transcripts in the provided genome file (-g). Only one
                        of -a/-g OR -s is REQUIRED.
  -g GENOME_FILE        A FASTA file containing a genome. -a must also be
                        specified. Only one of -a/-g OR -s is REQUIRED.
  -s IN_SEQ             Either a directory containing individual, in-frame
                        coding sequence files or a single file containing
                        multipl in-frame coding sequences on which to
                        calculate degeneracy. Only one of -a/-g OR -s is
                        REQUIRED.
  -v VCF_FILE           Optional VCF file with in and outgroups to output
                        polymorphic and fixed differences for MK tests. The
                        VCF should contain SNPs only (no indels or structural
                        variants).
  -u VCF_OUTGROUPS      A comma separated list of sample IDs in the VCF file
                        that make up the outgroup (e.g. 'sample1,sample2') or
                        a file with one sample per line.
  -e VCF_EXCLUDE        A comma separated list of sample IDs in the VCF file
                        to exclude (e.g. 'sample1,sample2') or a file with one
                        sample per line.
  -o OUT_DEST           Desired output directory. This will be created for you
                        if it doesn't exist. Default: degenotate-[date]-[time]
  -sfs                  Set this to output raw allele frequencies in the mk
                        table)
  -d SEQ_DELIM          degenotate assumes the chromosome IDs in the GFF file
                        exactly match the sequence headers in the FASTA file.
                        If this is not the case, use this to specify a
                        character at which the FASTA headers will be trimmed.
  -c [WRITE_CDS]        If a file is provided, the program will extract CDS
                        sequences from the genome and write them to the file
                        and exit. If no file is given with the option, a file
                        with the name of 'cds-nt.fa' will be written to the
                        output directory. Equivalent to '-x 0234' except this
                        stops the program before calculating degeneracy.
  -ca [WRITE_CDS_AA]    The same as -c, but writes translated amino acid
                        sequences instead. Both -c and -ca can be specified.
                        Default file name is 'cds-aa.fa'.
  -l [WRITE_LONGEST]    If a file is provided, the program will extract CDS
                        sequences from the longest transcript for each gene
                        and write them to the file and exit. If no file is
                        given with the option, a file with the name of 'cds-
                        nt-longest.fa' will be written to the output
                        directory. Both -c and -l can be specified.
  -la [WRITE_LONGEST_AA]
                        The same as -l, but writes translated amino acid
                        sequences instead. Both -l and -la can be specified.
                        Default file name is 'cds-aa-longest.fa'.
  -x EXTRACT_SEQ        Extract sites of a certain degeneracy. For instance,
                        to extract 4-fold degenerate sites enter '4'. To
                        extract 2- and 4-fold degenerate sites enter '24' and
                        so on.
  -m MIN_LENGTH         The minimum length of a transcript for it to be
                        counted. Default (and global min): 3
  -maf MAF_CUTOFF       The minor allele frequency cutoff for MK tests. Sites
                        where alternate alleles in the ingroup are below this
                        frequency will be excluded. Default: 1 / 2N, where N
                        is the number of ingroup samples
  -imp IMP_CUTOFF       The minor allele frequency cutoff that distinguishes
                        low and high allele frequencies for imputed MK test.
                        Only used if provided VCF is polarized. Default: 0.15
  --no-fixed-in         Set this if you wish to exclude sites from the MK test
                        in which all ingroup samples share the same alternate
                        allele (only the reference differs).
  --overwrite           Set this to overwrite existing files.
  --appendlog           Set this to keep the old log file even if --overwrite
                        is specified. New log information will instead be
                        appended to the previous log file.
  --info                Print some meta information about the program and
                        exit. No other options required.
  --version             Simply print the version and exit. Can also be called
                        as '-version', '-v', or '--v'
  --quiet               Set this flag to prevent degenotate from reporting
                        detailed information about each step.
```

