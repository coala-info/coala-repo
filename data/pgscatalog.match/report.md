# pgscatalog.match CWL Generation Report

## pgscatalog.match_pgscatalog-match

### Tool Description
Match variants from a combined scoring file against a set of target genomes from the same fileset, and output scoring files compatible with the plink2 --score function.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.match/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgscatalog.match/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-06-10
- **GitHub**: https://github.com/PGScatalog/pygscatalog
- **Stars**: N/A
### Original Help Text
```text
usage: pgscatalog-match [-h] -d DATASET -s SCOREFILE [SCOREFILE ...] -t TARGET
                        [TARGET ...] [-c CHROM] [--only_match]
                        [--min_overlap MIN_OVERLAP] [-IDs FILTER_IDS] --outdir
                        OUTDIR [--split] [--combined] [-v]
                        [--cleanup | --no-cleanup] [--keep_ambiguous]
                        [--keep_multiallelic] [--ignore_strand_flips]
                        [--keep_first_match]

Match variants from a combined scoring file against a set of
target genomes from the same fileset, and output scoring files
compatible with the plink2 --score function.

A combined scoring file is the output of the combine_scorefiles
script. It has the following structure:

    | chr_name | chr_position | ... | accession |
    | -------- | ------------ | --- | --------- |
    | 1        | 1            | ... | PGS000802 |

The combined scoring file is in long format, with one row per
variant for each scoring file (accession). This structure is
different to the PGS Catalog standard, because the long format
makes matching faster and simpler.

Target genomes can be in plink1 bim format or plink2 pvar
format. Variant IDs should be unique so that they can be specified
in the scoring file as: variant_id|effect_allele|[effect_weight column(s)...] 

Only one set of target genomes should be matched at a time. Don't
try to match target genomes from different plink filesets. Matching 
against a set of chromosomes from the same fileset is OK (see --split). 

options:
  -h, --help            show this help message and exit
  -d DATASET, --dataset DATASET
                        <Required> Label for target genomic dataset
  -s SCOREFILE [SCOREFILE ...], --scorefiles SCOREFILE [SCOREFILE ...]
                        <Required> Path to scorefile. Multiple paths supported
  -t TARGET [TARGET ...], --target TARGET [TARGET ...]
                        <Required> A list of paths of target genomic variants
                        (.bim format)
  -c CHROM, --chrom CHROM
                        <Optional> Set which chromosome is in the target
                        variant file to speed up matching
  --only_match          <Optional> Only match, then write intermediate files,
                        don't make scoring files
  --min_overlap MIN_OVERLAP
                        <Optional> Minimum proportion of variants to match
                        before error
  -IDs FILTER_IDS, --filter_IDs FILTER_IDS
                        <Optional> Path to file containing list of variant IDs
                        that can be included in the final scorefile.[useful
                        for limiting scoring files to variants present in
                        multiple datasets]
  --outdir OUTDIR       <Required> Output directory
  --split               <Optional> Split scorefile per chromosome?
  --combined            <Optional> Write scorefiles in combined format?
  -v, --verbose         <Optional> Extra logging information
  --cleanup, --no-cleanup
  --keep_ambiguous      <Optional> Flag to force the program to keep variants
                        with ambiguous alleles, (e.g. A/T and G/C SNPs), which
                        are normally excluded (default: false). In this case
                        the program proceeds assuming that the genotype data
                        is on the same strand as the GWAS whose summary
                        statistics were used to construct the score.
  --keep_multiallelic   <Optional> Flag to allow matching to multiallelic
                        variants (default: false).
  --ignore_strand_flips
                        <Optional> Flag to not consider matched variants that
                        may be reported on the opposite strand. Default
                        behaviour is to flip/complement unmatched variants and
                        check if they match.
  --keep_first_match    <Optional> If multiple match candidates for a variant
                        exist that can't be prioritised, keep the first match
                        candidate (default: drop all candidates)

match_variants will output at least one scoring file in a
format compatible with the plink2 --score function. This
output might be split across different files to ensure each
variant ID, effect allele, and effect type appears only once
in each file. Output files have the pattern:

    {dataset}_{chromosome}_{effect_type}_{n}.scorefile.

If multiple chromosomes are combined into a single file (i.e. not
--split), then {chromosome} is replaced with 'ALL'. Once the
scorefiles are used to calculate a score with plink2, the .sscore
files will need to be aggregated to calculate a single polygenic
score for each dataset, sample, and accession (scoring file). The
PGS Catalog Calculator does this automatically.
```


## pgscatalog.match_pgscatalog-matchmerge

### Tool Description
Match and merge score files with target genomic datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.match/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-matchmerge [-h] -d DATASET -s SCOREFILE [SCOREFILE ...] -m
                             MATCHES [MATCHES ...] --min_overlap MIN_OVERLAP
                             [-IDs FILTER_IDS] --outdir OUTDIR [--split]
                             [--combined] [-v] [--cleanup | --no-cleanup]
                             [--keep_ambiguous] [--keep_multiallelic]
                             [--ignore_strand_flips] [--keep_first_match]

options:
  -h, --help            show this help message and exit
  -d DATASET, --dataset DATASET
                        <Required> Label for target genomic dataset
  -s SCOREFILE [SCOREFILE ...], --scorefile SCOREFILE [SCOREFILE ...]
                        <Required> Path to scorefile. Multiple paths supported
  -m MATCHES [MATCHES ...], --matches MATCHES [MATCHES ...]
                        <Required> List of match files
  --min_overlap MIN_OVERLAP
                        <Required> Minimum proportion of variants to match
                        before error
  -IDs FILTER_IDS, --filter_IDs FILTER_IDS
                        <Optional> Path to file containing list of variant IDs
                        that can be included in the final scorefile.[useful
                        for limiting scoring files to variants present in
                        multiple datasets]
  --outdir OUTDIR       <Required> Output directory
  --split               <Optional> Write scorefiles split per chromosome?
  --combined            <Optional> Write scorefiles in combined format?
  -v, --verbose         <Optional> Extra logging information
  --cleanup, --no-cleanup
  --keep_ambiguous      <Optional> Flag to force the program to keep variants
                        with ambiguous alleles, (e.g. A/T and G/C SNPs), which
                        are normally excluded (default: false). In this case
                        the program proceeds assuming that the genotype data
                        is on the same strand as the GWAS whose summary
                        statistics were used to construct the score.
  --keep_multiallelic   <Optional> Flag to allow matching to multiallelic
                        variants (default: false).
  --ignore_strand_flips
                        <Optional> Flag to not consider matched variants that
                        may be reported on the opposite strand. Default
                        behaviour is to flip/complement unmatched variants and
                        check if they match.
  --keep_first_match    <Optional> If multiple match candidates for a variant
                        exist that can't be prioritised, keep the first match
                        candidate (default: drop all candidates)
```


## pgscatalog.match_pgscatalog-intersect

### Tool Description
Program to find matched variants (same strand) between a set of reference and target data .pvar/bim files. This also evaluate whether the variants in the TARGET are suitable for inclusion in a PCA analysis (excludes strand ambiguous and multi-allelic/INDEL variants), and can also uses the .afreq and .vmiss files exclude variants with missingness and MAF filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.match/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-intersect [-h] -r REFERENCE -t TARGET [TARGET ...]
                            [-c FILTER_CHROM] [--maf_target MAF_FILTER]
                            [--geno_miss VMISS_FILTER] [-v] --outdir OUTDIR
                            [--batch_size BATCH_SIZE]

Program to find matched variants (same strand) between a set of reference and target data .pvar/bim files. This 
also evaluate whether the variants in the TARGET are suitable for inclusion in  a PCA analysis (excludes strand 
ambiguous and multi-allelic/INDEL variants), and can also uses the .afreq and .vmiss files exclude variants with 
missingness and MAF filters. 

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        path/to/REFERENCE/pvar
  -t TARGET [TARGET ...], --target TARGET [TARGET ...]
                        <Required> A list of paths of target genomic variants
                        (.bim/pvar format). The .afreq and .vmiss files are
                        also required for these files.
  -c FILTER_CHROM, --chrom FILTER_CHROM
                        Whether to limit matches to specific chromosome of the
                        reference
  --maf_target MAF_FILTER
                        Filter: Minimum minor Allele Frequency for PCA
                        eligibility
  --geno_miss VMISS_FILTER
                        Filter: Maximum Genotype missingness for PCA
                        eligibility
  -v, --verbose         <Optional> Extra logging information
  --outdir OUTDIR       <Required> Output directory
  --batch_size BATCH_SIZE
                        <Optional> Number of variants processed per batch
```


## Metadata
- **Skill**: not generated
