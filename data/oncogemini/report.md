# oncogemini CWL Generation Report

## oncogemini_amend

### Tool Description
Amend a database with new sample information.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fakedrtom/oncogemini
- **Stars**: N/A
### Original Help Text
```text
usage: oncogemini amend [-h] [--sample sample] [--clear] db

positional arguments:
  db               The name of the database to be amended.

optional arguments:
  -h, --help       show this help message and exit
  --sample sample  New sample information file to load
  --clear          Set all values in this column to NULL before loading.
```


## oncogemini_annotate

### Tool Description
Annotate variants with information from a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini annotate [-h] -f ANNO_FILE [-c COL_NAMES]
                           [-a {boolean,count,extract}] [-e COL_EXTRACTS]
                           [-t COL_TYPES] [-o COL_OPERATIONS] [--region-only]
                           db

positional arguments:
  db                    The name of the database to be updated.

optional arguments:
  -h, --help            show this help message and exit
  -f ANNO_FILE          The TABIX'ed BED file containing the annotations
  -c COL_NAMES          The name(s) of the BED column(s) to be added to the
                        variant table.If the input file is a VCF, then this is
                        the name of the info field to pull.
  -a {boolean,count,extract}
                        How should the annotation file be used? (def. extract)
  -e COL_EXTRACTS       Column(s) to extract information from for list
                        annotations.If the input is VCF, then this defaults to
                        the fields specified in `-c`.
  -t COL_TYPES          What data type(s) should be used to represent the new
                        values in the database? Any of {integer, float, text}
  -o COL_OPERATIONS     Operation(s) to apply to the extract column values in
                        the event that a variant overlaps multiple annotations
                        in your annotation file (-f).Any of {sum, mean,
                        median, min, max, mode, list, uniq_list, first, last}
  --region-only         If set, only region coordinates will be considered
                        when annotating variants.The default is to annotate
                        using region coordinates as well as REF and ALT
                        variant valuesThis option is only valid if annotation
                        is a VCF file
```


## oncogemini_bottleneck

### Tool Description
Analyze bottleneck in cancer evolution

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini bottleneck [-h] [--minDP INTEGER] [--minGQ INTEGER]
                             [--maxNorm FLOAT] [--minSlope FLOAT]
                             [--minR FLOAT] [--samples STRING]
                             [--minEnd FLOAT] [--endDiff FLOAT]
                             [--patient STRING] [--columns STRING]
                             [--filter STRING] [--purity] [--somatic_only]
                             [--cancers STRING]
                             db

positional arguments:
  db                The name of the database to be queried

optional arguments:
  -h, --help        show this help message and exit
  --minDP INTEGER   Minimum depth required in all samples default is 0)
  --minGQ INTEGER   Minimum genotype quality required in all samples (default
                    is 0)
  --maxNorm FLOAT   Specify a maximum normal sample AF to allow (default is 0)
  --minSlope FLOAT  Minimum slope required for the AFs across samples (default
                    is 0.05)
  --minR FLOAT      Minimum r correlation coefficient required for AFs
                    (default is 0.5)
  --samples STRING  Rather than including all samples, a string of comma-
                    separated specified samples to use (default is "All")
  --minEnd FLOAT    Minimum AF required of the sample representing the final
                    timepoint (default is 0)
  --endDiff FLOAT   Minimum required AF difference between the samples
                    representing the first and final timepoints (default is 0)
  --patient STRING  Specify a patient to filter (should correspond to a
                    patient_id in ped file)
  --columns STRING  A list of columns that you would like returned (default is
                    "*", which returns every column)
  --filter STRING   Restrictions to apply to variants (SQL syntax)
  --purity          Using purity estimates in sample manifest file, make
                    corrections to AF to be used
  --somatic_only    Only include variants that have been marked as somatic via
                    the set_somatic command
  --cancers STRING  Restrict results to variants/genes associated with
                    specific cancer types by entering a comma-separated string
                    of cancer type abbreviations (see documents for
                    abbreviations) REQUIRES that db include
                    civic_gene_abbrevations and/or cgi_gene_abbreviations
```


## oncogemini_db_info

### Tool Description
Show information about a specific database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini db_info [-h] db

positional arguments:
  db          The name of the database to be updated.

optional arguments:
  -h, --help  show this help message and exit
```


## oncogemini_dump

### Tool Description
Dump data from the oncogemini database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini dump [-h] [--variants] [--genotypes] [--samples] [--header]
                       [--sep STRING] [--tfam]
                       db

positional arguments:
  db            The name of the database to be queried.

optional arguments:
  -h, --help    show this help message and exit
  --variants    Report all rows/columns from the variants table.
  --genotypes   Report all rows/columns from the variants table with one line
                per sample/genotype.
  --samples     Report all rows/columns from the samples table.
  --header      Add a header of column names to the output.
  --sep STRING  Output column separator
  --tfam        Output sample information to TFAM format.
```


## oncogemini_examples

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[stats] - report basic statistics about your variants:
   oncogemini stats --tstv my.db
   oncogemini stats --tstv-coding my.db
   oncogemini stats --sfs my.db
   oncogemini stats --snp-counts my.db

[query] - explore the database with ad hoc queries:
   oncogemini query -q "select * from variants where is_lof = 1 and aaf <= 0.01" my.db
   oncogemini query -q "select chrom, pos, gt_bases.NA12878 from variants" my.db
   oncogemini query -q "select chrom, pos, in_omim, clin_sigs from variants" my.db

[dump] - convenient "data dumps":
   oncogemini dump --variants my.db
   oncogemini dump --genotypes my.db
   oncogemini dump --samples my.db

[region] - access variants in specific genomic regions:
   oncogemini region --reg chr1:100-200 my.db
   oncogemini region --gene TP53 my.db

[tools] - there are also many specific tools available
   1. Find truncal variants.
     oncogemini truncal my.db
```


## oncogemini_fusions

### Tool Description
Query the database for fusions.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini fusions [-h] [--in_cosmic_census] [--min_qual FLOAT]
                          [--evidence_type STR]
                          db

positional arguments:
  db                   The name of the database to be queried.

optional arguments:
  -h, --help           show this help message and exit
  --in_cosmic_census   One or both genes in fusion is in COSMIC cancer census
  --min_qual FLOAT     The min variant quality (VCF QUAL) (def: None).
  --evidence_type STR  The supporting evidence types for the variant ("PE",
                       "SR", or "PE,SR").
```


## oncogemini_loh

### Tool Description
Filter and query LOH variants from a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini loh [-h] [--minDP INTEGER] [--minGQ INTEGER]
                      [--maxNorm FLOAT] [--minNorm FLOAT] [--minTumor FLOAT]
                      [--patient STRING] [--samples STRING] [--columns STRING]
                      [--filter STRING] [--purity] [--specific STRING]
                      [--cancers STRING]
                      db

positional arguments:
  db                 The name of the database to be queried.

optional arguments:
  -h, --help         show this help message and exit
  --minDP INTEGER    Minimum depth required in all samples default is 0)
  --minGQ INTEGER    Minimum genotype quality required in all samples (default
                     is 0)
  --maxNorm FLOAT    Specify a maximum normal sample AF to allow (default is
                     0.7)
  --minNorm FLOAT    Specify a minimum normal sample AF to allow (default is
                     0.3)
  --minTumor FLOAT   Specify a minimum AF for tumor samples to require
                     (default is 0.8)
  --patient STRING   Specify a patient to filter (should correspond to a
                     patient_id in ped file)
  --samples STRING   Rather than including all samples, enter a string of
                     comma-separated specified samples to use (default is
                     "All")
  --columns STRING   A comma-separated list of columns that you would like
                     returned (default is "*", which returns every column)
  --filter STRING    Restrictions to apply to variants (SQL syntax)
  --purity           Using purity estimates in sample manifest file, make
                     corrections to AF to be used
  --specific STRING  Search for LOH variants in a single sample compared to
                     the sample(s) that precede it (must specify single sample
                     included among --samples, also --minNorm, --maxNorm will
                     now apply to the preceding sample)
  --cancers STRING   Restrict results to variants/genes associated with
                     specific cancer types by entering a comma-separated
                     string of cancer type abbreviations (see documents for
                     abbreviations) REQUIRES that db include
                     civic_gene_abbrevations and/or cgi_gene_abbreviations
```


## oncogemini_query

### Tool Description
Query the oncogemini database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini query [-h] [-q QUERY_STR] [--gt-filter STRING]
                        [--show-samples] [--show-families] [--family-wise]
                        [--min-kindreds MIN_KINDREDS] [--sample-delim STRING]
                        [--header] [--sample-filter SAMPLE_FILTER]
                        [--in [{all,none,any,only,not} [{all,none,any,only,not} ...]]]
                        [--format FORMAT] [--region REGION]
                        [--carrier-summary-by-phenotype CARRIER_SUMMARY]
                        db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  -q QUERY_STR          The query to be issued to the database
  --gt-filter STRING    Restrictions to apply to genotype values
  --show-samples        Add a column of all sample names with a variant to
                        each variant.
  --show-families       Add a column listing all of the families with a
                        variant to each variant.
  --family-wise         Perform the sample-filter on a family-wise basis.
  --min-kindreds MIN_KINDREDS
                        Minimum number of families for a variant passing a
                        family-wise filter to be in.
  --sample-delim STRING
                        The delimiter to be used with the --show-samples
                        option.
  --header              Add a header of column names to the output.
  --sample-filter SAMPLE_FILTER
                        SQL filter to use to filter the sample table
  --in [{all,none,any,only,not} [{all,none,any,only,not} ...]]
                        A variant must be in either all, none or any samples
                        passing the --sample-query filter.
  --format FORMAT       Format of output (JSON, TPED or default)
  --region REGION       Restrict query to this region, e.g. chr1:10-20.
  --carrier-summary-by-phenotype CARRIER_SUMMARY
                        Output columns of counts of carriers and non-carriers
                        stratified by the given sample phenotype column
```


## oncogemini_region

### Tool Description
Query oncogemini database for regions or genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini region [-h] [--reg STRING] [--gene STRING] [--header]
                         [--columns STRING] [--filter STRING] [--show-samples]
                         [--format FORMAT]
                         db

positional arguments:
  db                The name of the database to be queried.

optional arguments:
  -h, --help        show this help message and exit
  --reg STRING      Specify a chromosomal region chr:start-end
  --gene STRING     Specify a gene of interest
  --header          Add a header of column names to the output.
  --columns STRING  A list of columns that you would like returned. Def. = "*"
  --filter STRING   Restrictions to apply to variants (SQL syntax)
  --show-samples    Add a column of all sample names with a variant to each
                    variant.
  --format FORMAT   Format of output (JSON, TPED or default)
```


## oncogemini_roh

### Tool Description
Finds regions of homozygosity (ROH) in a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini roh [-h] [--min-snps INTEGER] [--min-total-depth INTEGER]
                      [--min-gt-depth INTEGER] [--min-size INTEGER]
                      [--max-hets INTEGER] [--max-unknowns INTEGER]
                      [-s SAMPLES]
                      db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --min-snps INTEGER    Minimum number of homozygous snps expected in a run
                        (def. 25)
  --min-total-depth INTEGER
                        The minimum overall sequencing depth requiredfor a SNP
                        to be considered (def = 20).
  --min-gt-depth INTEGER
                        The minimum required sequencing depth underlying a
                        given sample's genotypefor a SNP to be considered (def
                        = 0).
  --min-size INTEGER    Minimum run size in base pairs (def. 100000)
  --max-hets INTEGER    Maximum number of allowed hets in the run (def. 1)
  --max-unknowns INTEGER
                        Maximum number of allowed unknowns in the run (def. 3)
  -s SAMPLES            Comma separated list of samples to screen for ROHs.
                        e.g S120,S450
```


## oncogemini_set_somatic

### Tool Description
Set somatic status for variants in a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini set_somatic [-h] [--minDP MINDP] [--minGQ MINGQ]
                              [--normAF NORMAF] [--normCount NORMCOUNT]
                              [--normDP NORMDP] [--tumAF TUMAF]
                              [--tumCount TUMCOUNT] [--tumDP TUMDP] [--purity]
                              [--dry-run]
                              db

positional arguments:
  db                    The name of the database to be updated.

optional arguments:
  -h, --help            show this help message and exit
  --minDP MINDP         Minimum depth required in all samples (default is 0)
  --minGQ MINGQ         Minimum genotype quality required in all samples
                        (default is 0)
  --normAF NORMAF       The maximum frequency of the alternate allele in the
                        normal sample (default 0).
  --normCount NORMCOUNT
                        The maximum count of the alternate allele in the
                        normal sample (default 0).
  --normDP NORMDP       The minimum depth allowed in the normal sample to
                        believe somatic (default 0).
  --tumAF TUMAF         The minimum frequency of the alternate allele in the
                        tumor sample (default 0).
  --tumCount TUMCOUNT   The minimum count of the alternate allele in the tumor
                        sample (default 0).
  --tumDP TUMDP         The minimum depth allowed in the tumor sample to
                        believe somatic (default 0).
  --purity              Using purity estimates in sample manifest file, make
                        corrections to AF to be used
  --dry-run             Don't set the is_somatic flag, just report what
                        _would_ be set. For testing parameters.
```


## oncogemini_stats

### Tool Description
Report statistics from the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini stats [-h] [--tstv] [--tstv-coding] [--tstv-noncoding]
                        [--snp-counts] [--sfs] [--mds] [--vars-by-sample]
                        [--gts-by-sample] [--summarize QUERY_STR]
                        [--gt-filter STRING]
                        db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --tstv                Report the overall ts/tv ratio.
  --tstv-coding         Report the ts/tv ratio in coding regions.
  --tstv-noncoding      Report the ts/tv ratio in non-coding regions.
  --snp-counts          Report the count of each type of SNP (A->G, G->T,
                        etc.).
  --sfs                 Report the site frequency spectrum of the variants.
  --mds                 Report the pairwise genetic distance between the
                        samples.
  --vars-by-sample      Report the number of variants observed in each sample.
  --gts-by-sample       Report the count of each genotype class obs. per
                        sample.
  --summarize QUERY_STR
                        The query to be issued to the database to summarize
  --gt-filter STRING    Restrictions to apply to genotype values
```


## oncogemini_truncal

### Tool Description
Query the database for truncal variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini truncal [-h] [--minDP INTEGER] [--minGQ INTEGER]
                          [--maxNorm FLOAT] [--patient STRING]
                          [--samples STRING] [--increase FLOAT]
                          [--columns STRING] [--filter STRING] [--purity]
                          [--somatic_only] [--cancers STRING]
                          db

positional arguments:
  db                The name of the database to be queried.

optional arguments:
  -h, --help        show this help message and exit
  --minDP INTEGER   Minimum depth required in all samples default is 0)
  --minGQ INTEGER   Minimum genotype quality required in all samples (default
                    is 0)
  --maxNorm FLOAT   Optional: specify a maximum normal sample AF to allow
                    (default is 0)
  --patient STRING  Specify a patient to filter (should correspond to a
                    patient_id in ped file)
  --samples STRING  Optional: rather than including all samples, a string of
                    comma-separated specified samples to use (default is
                    "All")
  --increase FLOAT  Optional: add amount to increase truncal AF filter between
                    normal and tumor samples (default is 0)
  --columns STRING  A list of columns that you would like returned (default is
                    "*", which returns every column)
  --filter STRING   Restrictions to apply to variants (SQL syntax)
  --purity          Using purity estimates in sample manifest file, make
                    corrections to AF to be used
  --somatic_only    Only include variants that have been marked as somatic via
                    the set_somatic command
  --cancers STRING  Restrict results to variants/genes associated with
                    specific cancer types by entering a comma-separated string
                    of cancer type abbreviations (see documents for
                    abbreviations) REQUIRES that db include
                    civic_gene_abbrevations and/or cgi_gene_abbreviations
```


## oncogemini_unique

### Tool Description
Identify unique variants in a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini unique [-h] [--minDP INTEGER] [--minGQ INTEGER]
                         [--specific STRING] [--maxOthers FLOAT]
                         [--patient STRING] [--samples STRING]
                         [--increase FLOAT] [--columns STRING]
                         [--filter STRING] [--purity] [--somatic_only]
                         [--cancers STRING]
                         db

positional arguments:
  db                 The name of the database to be queried.

optional arguments:
  -h, --help         show this help message and exit
  --minDP INTEGER    Minimum depth required in all samples default is 0)
  --minGQ INTEGER    Minimum genotype quality required in all samples (default
                     is 0)
  --specific STRING  Identify unique variants that exist only in samples from
                     this comma-separated list
  --maxOthers FLOAT  Specify a maximum sample AF to allow in other samples
                     (default is 0)
  --patient STRING   Specify a patient to filter (should correspond to a
                     patient_id in ped file)
  --samples STRING   Rather than including all samples in filters, a string of
                     comma-separated specified samples to use (default is
                     "All")
  --increase FLOAT   Add amount to increase AF filter between unique and other
                     samples (default is 0)
  --columns STRING   A list of columns that you would like returned (default
                     is "*", which returns every column)
  --filter STRING    Restrictions to apply to variants (SQL syntax)
  --purity           Using purity estimates in sample manifest file, make
                     corrections to AF to be used
  --somatic_only     Only include variants that have been marked as somatic
                     via the set_somatic command
  --cancers STRING   Restrict results to variants/genes associated with
                     specific cancer types by entering a comma-separated
                     string of cancer type abbreviations (see documents for
                     abbreviations) REQUIRES that db include
                     civic_gene_abbrevations and/or cgi_gene_abbreviations
```


## oncogemini_update

### Tool Description
Update oncogemini and its dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini update [-h] [--devel] [--dataonly] [--nodata]
                         [--extra {gerp_bp,cadd_score}] [--tooldir TOOLDIR]

optional arguments:
  -h, --help            show this help message and exit
  --devel               Get the latest development version instead of the
                        release
  --dataonly            Only update data, not the underlying libraries.
  --nodata              Do not install data dependencies
  --extra {gerp_bp,cadd_score}
                        Add additional non-standard genome annotations to
                        include
  --tooldir TOOLDIR     Directory for third party tools (ie /usr/local) update
```


## oncogemini_windower

### Tool Description
Windowing tool for oncogemini

### Metadata
- **Docker Image**: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
- **Homepage**: https://github.com/fakedrtom/oncogemini
- **Package**: https://anaconda.org/channels/bioconda/packages/oncogemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oncogemini windower [-h] [-w WINDOW_SIZE] [-s STEP_SIZE]
                           [-t {nucl_div,hwe}]
                           [-o {mean,median,min,max,collapse}]
                           db

positional arguments:
  db                    The name of the database to be updated.

optional arguments:
  -h, --help            show this help message and exit
  -w WINDOW_SIZE        The name of the column to be added to the variant
                        table.
  -s STEP_SIZE          The step size for the windows in bp.
  -t {nucl_div,hwe}     The type of windowed analysis requested.
  -o {mean,median,min,max,collapse}
                        The operation that should be applied to the -t values.
```

