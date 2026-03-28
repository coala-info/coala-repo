# slivar CWL Generation Report

## slivar_expr

### Tool Description
Evaluate expressions on VCF/BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
- **Homepage**: https://github.com/brentp/slivar
- **Package**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Total Downloads**: 86.7K
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/brentp/slivar
- **Stars**: N/A
### Original Help Text
```text
slivar expr

Usage:
  slivar expr [options] 

Options:
  -v, --vcf=VCF              path to VCF/BCF
  --region=REGION            optional region to limit evaluation. e.g. chr1 or 1:222-333 (or a BED file of regions)
  -x, --exclude=EXCLUDE      BED file of exclude regions (will never output excluded variants regardless of pass-only flag)
  -j, --js=JS                path to javascript functions to expose to user
  -p, --ped=PED              pedigree file with family relations, sex, and affected status
  -a, --alias=ALIAS          path to file of group aliases
  -o, --out-vcf=OUT_VCF      path to output VCF/BCF (default: /dev/stdout)
  --pass-only                only output variants that pass at least one of the filters
  --skip-non-variable        don't evaluate expression unless at least 1 sample is variable at the variant this can improve speed
  --trio=TRIO                expression(s) applied to each trio where 'mom', 'dad', 'kid' labels are available; trios inferred from ped file.
  --family-expr=FAMILY_EXPR  expression(s) applied to each family where 'fam' is available with a list of samples in each family from ped file.
  --group-expr=GROUP_EXPR    expression(s) applied to the groups defined in the alias option [see: https://github.com/brentp/slivar/wiki/groups-in-slivar].
  --sample-expr=SAMPLE_EXPR  expression(s) applied to each sample in the VCF.
  --info=INFO                expression using only attributes from  the INFO field or variant. If this does not pass trio/group/sample expressions are not applied.
  -g, --gnotate=GNOTATE      path(s) to compressed gnotate file(s)
  -h, --help                 Show this help
```


## slivar_make-gnotate

### Tool Description
Create gnotate files from VCFs

### Metadata
- **Docker Image**: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
- **Homepage**: https://github.com/brentp/slivar
- **Package**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Validation**: PASS

### Original Help Text
```text
slivar make-gnotate

Usage:
  slivar make-gnotate [options] [vcfs ...]

Arguments:
  [vcfs ...]       paths to vcf files

Options:
  --prefix=PREFIX            prefix for output (default: gno)
  -f, --field=FIELD          field(s) to pull from VCF. format is source:dest. e.g. AF_popmax:gnomad_popmax_af
  -m, --message=MESSAGE      optional usage message (or license) to associate with the gnotate file.
  -h, --help                 Show this help
slivar make-gnotate

Usage:
  slivar make-gnotate [options] [vcfs ...]

Arguments:
  [vcfs ...]       paths to vcf files

Options:
  --prefix=PREFIX            prefix for output (default: gno)
  -f, --field=FIELD          field(s) to pull from VCF. format is source:dest. e.g. AF_popmax:gnomad_popmax_af
  -m, --message=MESSAGE      optional usage message (or license) to associate with the gnotate file.
  -h, --help                 Show this help
```


## slivar_compound-hets

### Tool Description
find compound-hets in trios from pre-filtered variants

### Metadata
- **Docker Image**: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
- **Homepage**: https://github.com/brentp/slivar
- **Package**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Validation**: PASS

### Original Help Text
```text
slivar compound-hets

find compound-hets in trios from pre-filtered variants

Usage:
  slivar compound-hets [options] 

Options:
  -v, --vcf=VCF              input VCF (default: /dev/stdin)
  -s, --sample-field=SAMPLE_FIELD
                             optional INFO field(s) that contains list of samples (kids) that have passed previous filters.
can be specified multiple times. this is needed for multi-family VCFs
  -p, --ped=PED              required ped file describing the trios in the VCF
  --skip=SKIP                skip variants with these impacts (comma-separated) (default: splice_region,intergenic_region,intron,non_coding_transcript,non_coding,upstream_gene,downstream_gene,non_coding_transcript_exon,NMD_transcript,5_prime_UTR,3_prime_UTR)
  -o, --out-vcf=OUT_VCF      path to output VCF/BCF (default: /dev/stdout)
  -a, --allow-non-trios      allow samples with one or both parent unspecified. if this mode is used, any pair of heterozygotes co-occuring in the same gene, sample will be reported for samples without both parents that don't have kids. if a single parent is present some additional filtering is done.
  -h, --help                 Show this help
```


## slivar_tsv

### Tool Description
convert filtered VCF to tab-separated-value spreadsheet for final filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
- **Homepage**: https://github.com/brentp/slivar
- **Package**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Validation**: PASS

### Original Help Text
```text
slivar tsv

convert filtered VCF to tab-separated-value spreadsheet for final filtering

create a --gene-description file e.g. from human phenotype ontology with:
  wget -qO - http://purl.obolibrary.org/obo/hp/hpoa/phenotype_to_genes.txt | awk 'BEGIN{FS=OFS="\t"} (NR > 1) { print $4, $2 }' > gene_desc.txt
or from clinvar with:
  wget -qO - ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/gene_condition_source_id | cut -f 2,5 | grep -v ^$'\t' > clinvar_gene_desc.txt
or gene->pLI with:
   wget -qO - https://storage.googleapis.com/gnomad-public/release/2.1.1/constraint/gnomad.v2.1.1.lof_metrics.by_gene.txt.bgz | zcat \
       | cut -f 1,21,24 | tail -n+2 | awk '{ printf("%s\tpLI=%.3g;oe_lof=%.5g\n", $1, $2, $3)}'

    

Usage:
  slivar tsv [options] [vcf]

Arguments:
  [vcf]            input VCF (default: /dev/stdin)

Options:
  -p, --ped=PED              required ped file describing the trios in the VCF
  -c, --csq-field=CSQ_FIELD  INFO field containing the gene name and impact. Usually CSQ or BCSQ
  --csq-column=CSQ_COLUMN    CSQ sub-field(s) to extract (in addition to gene, impact, transcript). may be specified multiple times.
  -s, --sample-field=SAMPLE_FIELD
                             INFO field(s) that contains list of samples that have passed previous filters.
can be specified multiple times.
  -g, --gene-description=GENE_DESCRIPTION
                             tab-separated lookup of gene (column 1) to description (column 2) to add to output. the gene is case-sensitive. can be specified multiple times
  --impact-order=IMPACT_ORDER
                             ordering of impacts to override the default (https://raw.githubusercontent.com/brentp/slivar/master/src/slivarpkg/default-order.txt)
  -i, --info-field=INFO_FIELD
                             INFO field(s) that should be added to output (e.g. gnomad_popmax_af) can also use 'ID' or 'QUAL' to report those variant fields.
  -o, --out=OUT              path to output tab-separated file (default: /dev/stdout)
  -h, --help                 Show this help
```


## slivar_duo-del

### Tool Description
find denovo structural deletions in parent-child duos using non-transmission of SNPs

### Metadata
- **Docker Image**: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
- **Homepage**: https://github.com/brentp/slivar
- **Package**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Validation**: PASS

### Original Help Text
```text
slivar duodel

find denovo structural deletions in parent-child duos using non-transmission of SNPs
    see: https://github.com/brentp/slivar/wiki/finding-deletions-in-parent-child-duos
    

Usage:
  slivar duodel [options] [vcf]

Arguments:
  [vcf]            input SNP/indel VCF (default: /dev/stdin)

Options:
  -p, --ped=PED              required ped file describing the duos in the VCF
  -g, --gnotate=GNOTATE      optional gnotate file to check for flagged variants to exclude
  -s, --min-sites=MIN_SITES  minimum number of variants required to define a region (use 1 to output all putative deletions) (default: 3)
  -S, --min-size=MIN_SIZE    minimum size in base-pairs of a region (default: 50)
  -x, --exclude=EXCLUDE      path to BED file of exclude regions e.g. (LCRs or self-chains)
  -a, --affected-only        only output DEL calls for affected kids
  -h, --help                 Show this help
slivar duodel

find denovo structural deletions in parent-child duos using non-transmission of SNPs
    see: https://github.com/brentp/slivar/wiki/finding-deletions-in-parent-child-duos
    

Usage:
  slivar duodel [options] [vcf]

Arguments:
  [vcf]            input SNP/indel VCF (default: /dev/stdin)

Options:
  -p, --ped=PED              required ped file describing the duos in the VCF
  -g, --gnotate=GNOTATE      optional gnotate file to check for flagged variants to exclude
  -s, --min-sites=MIN_SITES  minimum number of variants required to define a region (use 1 to output all putative deletions) (default: 3)
  -S, --min-size=MIN_SIZE    minimum size in base-pairs of a region (default: 50)
  -x, --exclude=EXCLUDE      path to BED file of exclude regions e.g. (LCRs or self-chains)
  -a, --affected-only        only output DEL calls for affected kids
  -h, --help                 Show this help
```


## slivar_ddc

### Tool Description
Calculate DDC scores for variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
- **Homepage**: https://github.com/brentp/slivar
- **Package**: https://anaconda.org/channels/bioconda/packages/slivar/overview
- **Validation**: PASS

### Original Help Text
```text
slivar ddc

Usage:
  slivar ddc [options] vcf ped

Arguments:
  vcf
  ped

Options:
  --chrom=CHROM              limit to this chromosome only. use '-3' for all chromosomes (in the case of exome data) (default: chr15)
  --info-fields=INFO_FIELDS  comma-delimited list of info fields
  --fmt-fields=FMT_FIELDS    comma-delimited list of sample fields
  --html=HTML                path to output file (default: slivar-ddc.html)
  -h, --help                 Show this help
```


## Metadata
- **Skill**: generated
