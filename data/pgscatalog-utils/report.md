# pgscatalog-utils CWL Generation Report

## pgscatalog-utils_pgscatalog-download

### Tool Description
Download a set of scoring files from the PGS Catalog using PGS Scoring IDs, traits, or publication accessions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-08-25
- **GitHub**: https://github.com/PGScatalog/pygscatalog
- **Stars**: N/A
### Original Help Text
```text
usage: pgscatalog-download [-h] [-i PGS [PGS ...]] [-t EFO [EFO ...]] [-e]
                           [-p PGP [PGP ...]] [-b {GRCh37,GRCh38}] -o OUTDIR
                           [-w] [-c USER_AGENT] [-v]

Download a set of scoring files from the PGS Catalog using PGS Scoring
IDs, traits, or publication accessions.

The PGS Catalog API is queried to get a list of scoring file URLs.
Scoring files are downloaded asynchronously via HTTPS to a specified
directory. Downloaded files are automatically validated against an md5
checksum.

PGS Catalog scoring files are staged with the name:

    {PGS_ID}.txt.gz

If a valid build is specified harmonized files are downloaded as:

    {PGS_ID}_hmPOS_{genome_build}.txt.gz

These harmonised scoring files contain genomic coordinates, remapped
from author-submitted information such as rsIDs.

options:
  -h, --help            show this help message and exit
  -i PGS [PGS ...], --pgs PGS [PGS ...]
                        PGS Catalog ID(s) (e.g. PGS000001)
  -t EFO [EFO ...], --efo EFO [EFO ...]
                        Traits described by an EFO term(s) (e.g. EFO_0004611)
  -e, --efo_direct      <Optional> Return only PGS tagged with exact EFO term
                        (e.g. no PGS for child/descendant terms in the
                        ontology)
  -p PGP [PGP ...], --pgp PGP [PGP ...]
                        PGP publication ID(s) (e.g. PGP000007)
  -b {GRCh37,GRCh38}, --build {GRCh37,GRCh38}
                        Download harmonized scores with positions in genome
                        build: GRCh37 or GRCh38
  -o OUTDIR, --outdir OUTDIR
                        <Required> Output directory to store downloaded files
  -w, --overwrite       <Optional> Overwrite existing Scoring File if a new
                        version is available for download on the FTP
  -c USER_AGENT, --user_agent USER_AGENT
                        <Optional> Provide custom user agent when querying PGS
                        Catalog API
  -v, --verbose         <Optional> Extra logging information
```


## pgscatalog-utils_pgscatalog-match

### Tool Description
Match variants from a combined scoring file against a set of target genomes from the same fileset, and output scoring files compatible with the plink2 --score function.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-match [-h] -d DATASET -s SCOREFILE -t TARGET [TARGET ...]
                        [-c CHROM] [--only_match] [--min_overlap MIN_OVERLAP]
                        [-IDs FILTER_IDS] --outdir OUTDIR [--split]
                        [--combined] [-v] [--cleanup | --no-cleanup]
                        [--keep_ambiguous] [--keep_multiallelic]
                        [--ignore_strand_flips] [--keep_first_match]

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
  -s SCOREFILE, --scorefiles SCOREFILE
                        <Required> Combined scorefile path (output of
                        read_scorefiles.py)
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


## pgscatalog-utils_pgscatalog-matchmerge

### Tool Description
Match and merge score files with genotype data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-matchmerge [-h] -d DATASET -s SCOREFILE -m MATCHES
                             [MATCHES ...] --min_overlap MIN_OVERLAP
                             [-IDs FILTER_IDS] --outdir OUTDIR [--split]
                             [--combined] [-v] [--cleanup | --no-cleanup]
                             [--keep_ambiguous] [--keep_multiallelic]
                             [--ignore_strand_flips] [--keep_first_match]

options:
  -h, --help            show this help message and exit
  -d DATASET, --dataset DATASET
                        <Required> Label for target genomic dataset
  -s SCOREFILE, --scorefile SCOREFILE
                        <Required> Path to scorefile
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


## pgscatalog-utils_pgscatalog-intersect

### Tool Description
Program to find matched variants (same strand) between a set of reference and target data .pvar/bim files. This also evaluate whether the variants in the TARGET are suitable for inclusion in a PCA analysis (excludes strand ambiguous and multi-allelic/INDEL variants), and can also uses the .afreq and .vmiss files exclude variants with missingness and MAF filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
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


## pgscatalog-utils_pgscatalog-aggregate

### Tool Description
Aggregate plink .sscore files into a combined TSV table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-aggregate [-h] -s SCORES [SCORES ...] -o OUTDIR --split |
                            --no-split [-v] [--verify_variants]

Aggregate plink .sscore files into a combined TSV table.

This aggregation sums scores that were calculated from plink
.scorefiles. Scorefiles may be split to calculate scores over different
chromosomes or effect types. The PGS Catalog calculator automatically splits
scorefiles where appropriate, and uses this script to combine them.

Input .sscore files can be optionally compressed with zstd or gzip. 

The aggregated output scores are compressed with gzip.

options:
  -h, --help            show this help message and exit
  -s SCORES [SCORES ...], --scores SCORES [SCORES ...]
                        <Required> List of scorefile paths. Use a wildcard (*)
                        to select multiple files.
  -o OUTDIR, --outdir OUTDIR
                        <Required> Output directory to store downloaded files
  --split, --no-split   Make one aggregated file per sampleset
  -v, --verbose         <Optional> Extra logging information
  --verify_variants     <Optional> Verify variants from scoring file match
                        scored variants perfectly. Note: requires
                        .scorefile.gz files used by plink to create the
                        calculated score, and a .sscore.vars file output by
                        plink after scoring It's assumed that these files have
                        a common file name prefix (this is default plink
                        behaviour) e.g. cineca_22_additive_0.sscore.zst needs
                        cineca_22_additive_0.scorefile.gz &
                        cineca_22_additive_0.sscore.vars
```


## pgscatalog-utils_pgscatalog-ancestry-adjust

### Tool Description
Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current inputs: 
  - PCA projections from reference and target datasets (*.pcs) 
  - calculated polygenic scores (e.g. aggregated_scores.txt.gz), 
  - information about related samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id).

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-ancestry-adjust [-h] -d D_TARGET -r D_REF --ref_pcs REF_PCS
                                  [REF_PCS ...] --target_pcs TARGET_PCS
                                  [TARGET_PCS ...] --psam PSAM
                                  [-x REF_RELATED] [-p REF_LABEL]
                                  [-s SCOREFILE]
                                  [-a {RandomForest,Mahalanobis}]
                                  [--n_popcomp [1-20]] [-t PTHRESHOLD]
                                  [-n {empirical,mean,mean+var} [{empirical,mean,mean+var} ...]]
                                  [--n_normalization [1-20]] --outdir OUTDIR
                                  [-v]

Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current inputs: 
  - PCA projections from reference and target datasets (*.pcs)
  - calculated polygenic scores (e.g. aggregated_scores.txt.gz), 
  - information about related samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id).

options:
  -h, --help            show this help message and exit
  -d D_TARGET, --dataset D_TARGET
                        <Required> Label of the TARGET genomic dataset
  -r D_REF, --reference D_REF
                        <Required> Label of the REFERENCE genomic dataset
  --ref_pcs REF_PCS [REF_PCS ...]
                        <Required> Principal components path (output from
                        fraposa_pgsc)
  --target_pcs TARGET_PCS [TARGET_PCS ...]
                        <Required> Principal components path (output from
                        fraposa_pgsc)
  --psam PSAM           <Required> Reference sample information file path in
                        plink2 psam format)
  -x REF_RELATED, --reference_related REF_RELATED
                        File of related sample IDs (excluded from training
                        ancestry assignments)
  -p REF_LABEL, --pop_label REF_LABEL
                        Population labels in REFERENCE psam to use for
                        assignment
  -s SCOREFILE, --agg_scores SCOREFILE
                        Aggregated scores in PGS Catalog format ([sampleset,
                        IID] indexed)
  -a {RandomForest,Mahalanobis}, --ancestry_method {RandomForest,Mahalanobis}
                        Method used for population/ancestry assignment
  --n_popcomp [1-20]    Number of PCs used for population comparison (default
                        = 5)
  -t PTHRESHOLD, --pval_threshold PTHRESHOLD
                        p-value threshold used to identify low-confidence
                        ancestry similarities
  -n {empirical,mean,mean+var} [{empirical,mean,mean+var} ...], --normalization_method {empirical,mean,mean+var} [{empirical,mean,mean+var} ...]
                        Method used for adjustment of PGS using genetic
                        ancestry
  --n_normalization [1-20]
                        Number of PCs used for population NORMALIZATION
                        (default = 4)
  --outdir OUTDIR       <Required> Output directory
  -v, --verbose         <Optional> Extra logging information
```


## pgscatalog-utils_pgscatalog-relabel

### Tool Description
Relabel the column values in one file based on a pair of columns in another

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-relabel [-h] -d DATASET -m MAP_FILES [MAP_FILES ...] -o
                          OUTDIR --col_from COL_FROM --col_to COL_TO
                          --target_file TARGET_FILE --target_col TARGET_COL
                          [-v] [--split] [--combined] [-cc COMMENT_CHAR]

Relabel the column values in one file based on a pair of columns in another

options:
  -h, --help            show this help message and exit
  -d DATASET, --dataset DATASET
                        <Required> Label for target genomic dataset
  -m MAP_FILES [MAP_FILES ...], --maps MAP_FILES [MAP_FILES ...]
                        mapping filenames
  -o OUTDIR, --outdir OUTDIR
                        output directory
  --col_from COL_FROM   column to change FROM
  --col_to COL_TO       column to change TO
  --target_file TARGET_FILE
                        target file
  --target_col TARGET_COL
                        target column to revalue
  -v, --verbose         <Optional> Extra logging information
  --split
  --combined
  -cc COMMENT_CHAR, --comment_char COMMENT_CHAR
```


## Metadata
- **Skill**: generated
