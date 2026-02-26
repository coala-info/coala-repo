# gemini CWL Generation Report

## gemini_actionable_mutations

### Tool Description
Query the database for actionable mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Total Downloads**: 145.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arq5x/gemini
- **Stars**: N/A
### Original Help Text
```text
usage: gemini actionable_mutations [-h] db

positional arguments:
  db          The name of the database to be queried.

optional arguments:
  -h, --help  show this help message and exit
```


## gemini_amend

### Tool Description
Amend a Gemini database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini amend [-h] [--sample sample] [--clear] db

positional arguments:
  db               The name of the database to be amended.

optional arguments:
  -h, --help       show this help message and exit
  --sample sample  New sample information file to load
  --clear          Set all values in this column to NULL before loading.
```


## gemini_annotate

### Tool Description
Annotate a gemini database with information from a TABIX'ed BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini annotate [-h] -f ANNO_FILE [-c COL_NAMES]
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


## gemini_autosomal_dominant

### Tool Description
Identify candidate variants for autosomal dominant inheritance.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini autosomal_dominant [-h] [--columns STRING] [--filter STRING]
                                 [--min-kindreds MIN_KINDREDS]
                                 [--families FAMILIES] [--lenient]
                                 [--allow-unaffected] [-d MIN_SAMPLE_DEPTH]
                                 [--min-gq MIN_GQ] [--gt-pl-max GT_PHRED_LL]
                                 db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --lenient             Loosen the restrictions on family structure
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
  --gt-pl-max GT_PHRED_LL
                        The maximum phred-scaled genotype likelihod (PL)
                        allowed for each sample in a family.
```


## gemini_autosomal_recessive

### Tool Description
Find autosomal recessive variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini autosomal_recessive [-h] [--columns STRING] [--filter STRING]
                                  [--min-kindreds MIN_KINDREDS]
                                  [--families FAMILIES] [--lenient]
                                  [--allow-unaffected] [-d MIN_SAMPLE_DEPTH]
                                  [--min-gq MIN_GQ] [--gt-pl-max GT_PHRED_LL]
                                  db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --lenient             Loosen the restrictions on family structure
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
  --gt-pl-max GT_PHRED_LL
                        The maximum phred-scaled genotype likelihod (PL)
                        allowed for each sample in a family.
```


## gemini_bcolz_index

### Tool Description
Index a Gemini database with bcolz.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini bcolz_index [-h] [--cols COLS] db

positional arguments:
  db           The path of the database to indexed with bcolz.

optional arguments:
  -h, --help   show this help message and exit
  --cols COLS  list of gt columns to index. default is all
```


## gemini_browser

### Tool Description
Launch the Gemini browser

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini browser [-h] [--use use] [--host host] [--port port] db

positional arguments:
  db           The name of the database to be queried.

optional arguments:
  -h, --help   show this help message and exit
  --use use    Which browser to use: builtin or puzzle
  --host host  Hostname, default: localhost.
  --port port  Port, default: 8088.
```


## gemini_burden

### Tool Description
Calculate burden statistics for variants in a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini burden [-h] [--nonsynonymous] [--cases [CASES [CASES ...]]]
                     [--controls [CONTROLS [CONTROLS ...]]] [--calpha]
                     [--permutations PERMUTATIONS] [--min-aaf MIN_AAF]
                     [--max-aaf MAX_AAF] [--save_tscores]
                     db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --nonsynonymous       Count all nonsynonymous variants as contributing
                        burden.
  --cases [CASES [CASES ...]]
                        Space separated list of cases for association testing.
  --controls [CONTROLS [CONTROLS ...]]
                        Space separated list of controls for association
                        testing.
  --calpha              Run the C-alpha association test.
  --permutations PERMUTATIONS
                        Number of permutations to run for the C-alpha test
                        (try 1000 to start).
  --min-aaf MIN_AAF     The min. alt. allele frequency for a variant to be
                        included.
  --max-aaf MAX_AAF     The max. alt. allele frequency for a variant to be
                        included.
  --save_tscores        Save the permuted T-scores to a file.
```


## gemini_comp_hets

### Tool Description
Find compound heterozygous variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini comp_hets [-h] [--columns STRING] [--filter STRING]
                        [--min-kindreds MIN_KINDREDS] [--families FAMILIES]
                        [--allow-unaffected] [-d MIN_SAMPLE_DEPTH]
                        [--min-gq MIN_GQ] [--gt-pl-max GT_PHRED_LL]
                        [--gene-where WHERE] [--pattern-only]
                        [--max-priority MAX_PRIORITY]
                        db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
  --gt-pl-max GT_PHRED_LL
                        The maximum phred-scaled genotype likelihod (PL)
                        allowed for each sample in a family.
  --gene-where WHERE    SQL clause to limit variants to genes. a reasonable
                        alternative could be "gene != ''"
  --pattern-only        find compound hets by inheritance pattern, without
                        regard to affection
  --max-priority MAX_PRIORITY
                        Default (1) is to show only confident compound hets.
                        Set to 2 or higher to include pairs that are less
                        likely true comp-hets
```


## gemini_db_info

### Tool Description
Show information about a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini db_info [-h] db

positional arguments:
  db          The name of the database to be updated.

optional arguments:
  -h, --help  show this help message and exit
```


## gemini_de_novo

### Tool Description
Find de novo mutations

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini de_novo [-h] [--columns STRING] [--filter STRING]
                      [--min-kindreds MIN_KINDREDS] [--families FAMILIES]
                      [--lenient] [--allow-unaffected] [-d MIN_SAMPLE_DEPTH]
                      [--min-gq MIN_GQ] [--gt-pl-max GT_PHRED_LL]
                      db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --lenient             Loosen the restrictions on family structure
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
  --gt-pl-max GT_PHRED_LL
                        The maximum phred-scaled genotype likelihod (PL)
                        allowed for each sample in a family.
```


## gemini_dump

### Tool Description
Report all rows/columns from the variants table.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini dump [-h] [--variants] [--genotypes] [--samples] [--header]
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


## gemini_examples

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[load] - load a VCF file into a gemini database:
   gemini load -v my.vcf my.db
   gemini load -v my.vcf -t snpEff my.db
   gemini load -v my.vcf -t VEP my.db

[stats] - report basic statistics about your variants:
   gemini stats --tstv my.db
   gemini stats --tstv-coding my.db
   gemini stats --sfs my.db
   gemini stats --snp-counts my.db

[query] - explore the database with ad hoc queries:
   gemini query -q "select * from variants where is_lof = 1 and aaf <= 0.01" my.db
   gemini query -q "select chrom, pos, gt_bases.NA12878 from variants" my.db
   gemini query -q "select chrom, pos, in_omim, clin_sigs from variants" my.db

[dump] - convenient "data dumps":
   gemini dump --variants my.db
   gemini dump --genotypes my.db
   gemini dump --samples my.db

[region] - access variants in specific genomic regions:
   gemini region --reg chr1:100-200 my.db
   gemini region --gene TP53 my.db

[tools] - there are also many specific tools available
   1. Find compound heterozygotes.
     gemini comp_hets my.db
```


## gemini_fusions

### Tool Description
Query the database for fusion events.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini fusions [-h] [--in_cosmic_census] [--min_qual FLOAT]
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


## gemini_gene_wise

### Tool Description
Perform gene-wise analysis on a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini gene_wise [-h] [--min-filters MIN_FILTERS] [--where WHERE]
                        [--gt-filter GT_FILTER]
                        [--gt-filter-required GT_FILTER_REQUIRED]
                        [--filter FILTER] [--columns COLUMNS]
                        db

positional arguments:
  db

optional arguments:
  -h, --help            show this help message and exit
  --min-filters MIN_FILTERS
  --where WHERE         where clause to subset variants. [default "is_exonic =
                        1 AND impact_severity != 'LOW'"]
  --gt-filter GT_FILTER
  --gt-filter-required GT_FILTER_REQUIRED
                        specify filter(s) that must be met.a variant passing
                        this does filter is required and does not contribute
                        to '--min-filters
  --filter FILTER
  --columns COLUMNS
```


## gemini_interactions

### Tool Description
Query gemini database for interactions

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini interactions [-h] [-g GENE] [-r RADIUS] [--edges EDGES] [--var]
                           db

positional arguments:
  db             The name of the database to be queried

optional arguments:
  -h, --help     show this help message and exit
  -g GENE        Gene to be used as a root in BFS/shortest_path
  -r RADIUS      Set filter for BFS: valid numbers starting from 0
  --edges EDGES  edges file (default is hprd). Format is geneA|geneB
                 geneA|geneC...
  --var          var mode: Returns variant info (e.g. impact, biotype) for
                 interacting genes
```


## gemini_load

### Tool Description
Load variants and annotations from a VCF file into a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini load [-h] [-v VCF] [-t {snpEff,VEP,BCFT,all}] [-p PED_FILE]
                   [--skip-gerp-bp] [--skip-cadd] [--skip-gene-tables]
                   [--save-info-string] [--no-load-genotypes] [--no-genotypes]
                   [--cores CORES] [--scheduler {lsf,sge,slurm,torque}]
                   [--queue QUEUE] [--tempdir TEMPDIR] [--passonly]
                   [--test-mode] [--skip-pls]
                   db

positional arguments:
  db                    The name of the database to be created.

optional arguments:
  -h, --help            show this help message and exit
  -v VCF                The VCF file to be loaded.
  -t {snpEff,VEP,BCFT,all}
                        The annotations to be used with the input vcf.
  -p PED_FILE           Sample information file in PED+ format.
  --skip-gerp-bp        Do not load GERP scores at base pair resolution.
                        Loaded by default.
  --skip-cadd           Do not load CADD scores. Loaded by default
  --skip-gene-tables    Do not load gene tables. Loaded by default.
  --save-info-string    Load INFO string from VCF file. Not loaded by default
  --no-load-genotypes   Genotypes exist in the file, but should not be stored.
  --no-genotypes        There are no genotypes in the file (e.g. some 1000G
                        VCFs)
  --cores CORES         Number of cores to use to load in parallel.
  --scheduler {lsf,sge,slurm,torque}
                        Cluster scheduler to use.
  --queue QUEUE         Cluster queue to use.
  --tempdir TEMPDIR     Temp directory for storing intermediate files when
                        loading in parallel.
  --passonly            Keep only variants that pass all filters.
  --test-mode           Load in test mode (faster)
  --skip-pls            dont create columns for phred-scaled genotype
                        likelihoods
```


## gemini_load_chunk

### Tool Description
Load a VCF file into a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini load_chunk [-h] [-v VCF] [-t STRING] [-o OFFSET] [-p PED_FILE]
                         [--no-load-genotypes] [--no-genotypes]
                         [--skip-gerp-bp] [--skip-cadd] [--skip-gene-tables]
                         [--skip-info-string] [--passonly] [--test-mode]
                         [--skip-pls] [--tempdir TEMPDIR]
                         db

positional arguments:
  db                   The name of the database to be created.

optional arguments:
  -h, --help           show this help message and exit
  -v VCF               The VCF file to be loaded.
  -t STRING            The annotations to be used with the input vcf. Options
                       are: snpEff - Annotations as reported by snpEff. BCFT -
                       Annotations as reported by bcftools. VEP - Annotations
                       as reported by VEP.
  -o OFFSET            The starting number for the variant_ids
  -p PED_FILE          Sample information file in PED+ format.
  --no-load-genotypes  Genotypes exist in the file, but should not be stored.
  --no-genotypes       There are no genotypes in the file (e.g. some 1000G
                       VCFs)
  --skip-gerp-bp       Do not load GERP scores at base pair resolution. Loaded
                       by default.
  --skip-cadd          Do not load CADD scores. Loaded by default
  --skip-gene-tables   Do not load gene tables. Loaded by default.
  --skip-info-string   Do not load INFO string from VCF file to reduce DB
                       size. Loaded by default
  --passonly           Keep only variants that pass all filters.
  --test-mode          Load in test mode (faster)
  --skip-pls           dont create columns for phred-scaled genotype
                       likelihoods
  --tempdir TEMPDIR    Local (non-NFS) temp directory to use for working
                       around SQLite locking issues on NFS drives.
```


## gemini_lof_interactions

### Tool Description
Finds interactions for genes that harbor LoF variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini lof_interactions [-h] [-r RADIUS] [--edges EDGES] [--var] db

positional arguments:
  db             The name of the database to be queried

optional arguments:
  -h, --help     show this help message and exit
  -r RADIUS      set filter for BFS:
  --edges EDGES  edges file (default is hprd). Format is geneA|geneB
                 geneA|geneC...
  --var          var mode: Returns variant info (e.g. impact, biotype) for
                 interacting genes
```


## gemini_lof_sieve

### Tool Description
Queries the database for LOF variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini lof_sieve [-h] db

positional arguments:
  db          The name of the database to be queried

optional arguments:
  -h, --help  show this help message and exit
```


## gemini_mendel_errors

### Tool Description
Identify mendelian errors in a family structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini mendel_errors [-h] [--columns STRING] [--filter STRING]
                            [--min-kindreds MIN_KINDREDS]
                            [--families FAMILIES] [--lenient]
                            [-d MIN_SAMPLE_DEPTH] [--min-gq MIN_GQ]
                            [--gt-pl-max GT_PHRED_LL] [--only-affected]
                            db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --lenient             Loosen the restrictions on family structure
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
  --gt-pl-max GT_PHRED_LL
                        The maximum phred-scaled genotype likelihod (PL)
                        allowed for each sample in a family.
  --only-affected       only consider candidates from affected samples.
```


## gemini_merge_chunks

### Tool Description
Merge multiple chunked databases into a single database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini merge_chunks [-h] [--db DB] [--vcf VCF]
                           [-t {snpEff,VEP,BCFT,all}]
                           [--chunkdb [CHUNKDBS [CHUNKDBS ...]]]
                           [--tempdir TEMPDIR] [--index] [--skip-pls]

optional arguments:
  -h, --help            show this help message and exit
  --db DB               The name of the final database to be loaded.
  --vcf VCF             Original VCF file, for retrieving extra annotation
                        fields.
  -t {snpEff,VEP,BCFT,all}
                        The annotations to be used with the input vcf.
  --chunkdb [CHUNKDBS [CHUNKDBS ...]]
  --tempdir TEMPDIR     Local (non-NFS) temp directory to use for working
                        around SQLite locking issues on NFS drives.
  --index               Create all database indexes. If multiple merges are
                        used to create a database, only the last merge should
                        create the indexes.
  --skip-pls            dont create columns for phred-scaled genotype
                        likelihoods
```


## gemini_pathways

### Tool Description
Report pathways for indivs/genes/sites with LoF variants

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini pathways [-h] [-v STRING] [--lof] db

positional arguments:
  db          The name of the database to be queried

optional arguments:
  -h, --help  show this help message and exit
  -v STRING   Version of ensembl genes to use. Supported versions: 66 to 71
  --lof       Report pathways for indivs/genes/sites with LoF variants
```


## gemini_qc

### Tool Description
Run quality control tests on a Gemini database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini qc [-h] [--mode STRING] [--chrom STRING] db

positional arguments:
  db              The name of the database to be queried.

optional arguments:
  -h, --help      show this help message and exit
  --mode STRING   What type of QC should be run? [sex]
  --chrom STRING  Which chromosome should the sex test be applied to? [chrX]
```


## gemini_query

### Tool Description
Query the GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini query [-h] [-q QUERY_STR] [--gt-filter STRING] [--show-samples]
                    [--show-families] [--family-wise]
                    [--min-kindreds MIN_KINDREDS] [--sample-delim STRING]
                    [--header] [--sample-filter SAMPLE_FILTER]
                    [--in [{all,none,any,only,not} [{all,none,any,only,not} ...]]]
                    [--format FORMAT] [--region REGION]
                    [--carrier-summary-by-phenotype CARRIER_SUMMARY] [--dgidb]
                    [--use-bcolz]
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
  --dgidb               Request drug-gene interaction info from DGIdb.
  --use-bcolz           use a (previously created) bcolz index to speed
                        genotype queries
```


## gemini_region

### Tool Description
Query regions in a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini region [-h] [--reg STRING] [--gene STRING] [--header]
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


## gemini_roh

### Tool Description
Finds regions of homozygosity (ROH) in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini roh [-h] [--min-snps INTEGER] [--min-total-depth INTEGER]
                  [--min-gt-depth INTEGER] [--min-size INTEGER]
                  [--max-hets INTEGER] [--max-unknowns INTEGER] [-s SAMPLES]
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


## gemini_set_somatic

### Tool Description
Set the is_somatic flag for variants in a gemini database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini set_somatic [-h] [--min-depth MIN_DEPTH] [--min-qual MIN_QUAL]
                          [--min-somatic-score MIN_SOMATIC_SCORE]
                          [--max-norm-alt-freq MAX_NORM_ALT_FREQ]
                          [--max-norm-alt-count MAX_NORM_ALT_COUNT]
                          [--min-norm-depth MIN_NORM_DEPTH]
                          [--min-tumor-alt-freq MIN_TUMOR_ALT_FREQ]
                          [--min-tumor-alt-count MIN_TUMOR_ALT_COUNT]
                          [--min-tumor-depth MIN_TUMOR_DEPTH] [--chrom STRING]
                          [--dry-run]
                          db

positional arguments:
  db                    The name of the database to be updated.

optional arguments:
  -h, --help            show this help message and exit
  --min-depth MIN_DEPTH
                        The min combined depth for tumor + normal (def: 0).
  --min-qual MIN_QUAL   The min variant quality (VCF QUAL) (def: 0).
  --min-somatic-score MIN_SOMATIC_SCORE
                        The min somatic score (SSC) (def: 0).
  --max-norm-alt-freq MAX_NORM_ALT_FREQ
                        The max freq. of the alt. allele in the normal sample
                        (def: 0).
  --max-norm-alt-count MAX_NORM_ALT_COUNT
                        The max count. of the alt. allele in the normal sample
                        (def: 0).
  --min-norm-depth MIN_NORM_DEPTH
                        The minimum depth allowed in the normal sample to
                        believe somatic (def: 0).
  --min-tumor-alt-freq MIN_TUMOR_ALT_FREQ
                        The min freq. of the alt. allele in the tumor sample
                        (def: 0).
  --min-tumor-alt-count MIN_TUMOR_ALT_COUNT
                        The min count. of the alt. allele in the tumor sample
                        (def: 0).
  --min-tumor-depth MIN_TUMOR_DEPTH
                        The minimum depth allowed in the tumor sample to
                        believe somatic (def: 0).
  --chrom STRING        A specific chromosome on which to tag somatic
                        mutations. (def: None).
  --dry-run             Don't set the is_somatic flag, just report what
                        _would_ be set. For testing parameters.
```


## gemini_stats

### Tool Description
Report statistics about variants in a GEMINI database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini stats [-h] [--tstv] [--tstv-coding] [--tstv-noncoding]
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


## gemini_update

### Tool Description
Update GEMINI database and associated tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini update [-h] [--devel] [--dataonly] [--nodata]
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


## gemini_windower

### Tool Description
Window a database for analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini windower [-h] [-w WINDOW_SIZE] [-s STEP_SIZE]
                       [-t {nucl_div,hwe}] [-o {mean,median,min,max,collapse}]
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


## gemini_x_linked_de_novo

### Tool Description
Find X-linked de novo variants

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini x_linked_de_novo [-h] [-X X] [--columns STRING]
                               [--filter STRING] [--min-kindreds MIN_KINDREDS]
                               [--families FAMILIES] [--allow-unaffected]
                               [-d MIN_SAMPLE_DEPTH] [--min-gq MIN_GQ]
                               db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  -X X                  name of X chrom (if not default 'chrX' or 'X')
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
```


## gemini_x_linked_dominant

### Tool Description
Identify candidate variants for X-linked dominant inheritance.

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini x_linked_dominant [-h] [-X X] [--columns STRING]
                                [--filter STRING]
                                [--min-kindreds MIN_KINDREDS]
                                [--families FAMILIES] [--allow-unaffected]
                                [-d MIN_SAMPLE_DEPTH] [--min-gq MIN_GQ]
                                db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  -X X                  name of X chrom (if not default 'chrX' or 'X')
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
```


## gemini_x_linked_recessive

### Tool Description
Find X-linked recessive variants

### Metadata
- **Docker Image**: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
- **Homepage**: https://github.com/arq5x/gemini
- **Package**: https://anaconda.org/channels/bioconda/packages/gemini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemini x_linked_recessive [-h] [-X X] [--columns STRING]
                                 [--filter STRING]
                                 [--min-kindreds MIN_KINDREDS]
                                 [--families FAMILIES] [--allow-unaffected]
                                 [-d MIN_SAMPLE_DEPTH] [--min-gq MIN_GQ]
                                 db

positional arguments:
  db                    The name of the database to be queried.

optional arguments:
  -h, --help            show this help message and exit
  -X X                  name of X chrom (if not default 'chrX' or 'X')
  --columns STRING      A list of columns that you would like returned. Def. =
                        "*"
  --filter STRING       Restrictions to apply to variants (SQL syntax)
  --min-kindreds MIN_KINDREDS
                        The min. number of kindreds that must have a candidate
                        variant in a gene.
  --families FAMILIES   Restrict analysis to a specific set of 1 or more
                        (comma) separated) families
  --allow-unaffected    Report candidates that also impact samples labeled as
                        unaffected.
  -d MIN_SAMPLE_DEPTH   The minimum aligned sequence depth required for each
                        sample in a family (default = 0)
  --min-gq MIN_GQ       The minimum genotype quality required for each sample
                        in a family (default = 0)
```

