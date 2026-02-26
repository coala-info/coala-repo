# tb-profiler CWL Generation Report

## tb-profiler_profile

### Tool Description
Profile TB samples

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Total Downloads**: 130.8K
- **Last updated**: 2025-12-02
- **GitHub**: https://github.com/jodyphelan/TBProfiler
- **Stars**: N/A
### Original Help Text
```text
Usage: tb-profiler profile [-h] [--read1 READ1] [--read2 READ2] [--bam BAM]
                           [--fasta FASTA] [--vcf VCF]
                           [--platform {illumina,nanopore,pacbio}] [--db DB]
                           [--external_db EXTERNAL_DB] [--prefix PREFIX]
                           [--csv] [--txt] [--text_template TEXT_TEMPLATE]
                           [--docx] [--docx_template DOCX_TEMPLATE]
                           [--docx_plugin {default}]
                           [--add_columns ADD_COLUMNS] [--dir DIR]
                           [--depth DEPTH] [--af AF] [--strand STRAND]
                           [--sv_depth SV_DEPTH] [--sv_af SV_AF]
                           [--sv_len SV_LEN]
                           [--mapper {bwa,minimap2,bowtie2,bwa-mem2}]
                           [--caller {bcftools,freebayes,gatk,pilon,lofreq,freebayes-haplotype}]
                           [--calling_params CALLING_PARAMS]
                           [--kmer_counter {FastK,kmc,dsk}]
                           [--coverage_tool {samtools,bedtools}] [--suspect]
                           [--spoligotype] [--call_whole_genome]
                           [--snp_dist SNP_DIST] [--no_trim]
                           [--no_coverage_qc] [--no_samclip] [--no_delly]
                           [--threads THREADS] [--ram RAM] [--implement_rules]
                           [--snpeff_config SNPEFF_CONFIG]
                           [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--db_dir DB_DIR] [--temp TEMP] [--version]

Options:
  -h, --help            show this help message and exit

Input Options:
  --read1, -1 READ1     First read file (default: None)
  --read2, -2 READ2     Second read file (default: None)
  --bam, -a BAM         BAM file (make sure it has been generated using the
                        H37Rv genome (GCA_000195955.2)) (default: None)
  --fasta, -f FASTA     Fasta file (default: None)
  --vcf, -v VCF         VCF file (default: None)
  --platform, -m {illumina,nanopore,pacbio}
                        NGS Platform used to generate data (default: illumina)
  --db DB               Mutation panel name (default: tbdb)
  --external_db, --external-db EXTERNAL_DB
                        Path to db files prefix (overrides --db parameter)
                        (default: None)

Output Options:
  --prefix, -p PREFIX   Sample prefix for all results generated (default:
                        tbprofiler)
  --csv                 Add CSV output (default: False)
  --txt                 Add text output (default: False)
  --text_template, --text-template TEXT_TEMPLATE
                        Jinja2 formatted template for output (default: None)
  --docx                Add docx output (default: False)
  --docx_template, --docx-template DOCX_TEMPLATE
                        Supply custom template for --docx output (default:
                        None)
  --docx_plugin, --docx-plugin {default}
                        Use a plugin template for --docx output (default:
                        None)
  --add_columns, --add-columns ADD_COLUMNS
                        Add additional columns found in the mutation database
                        to the text and csv results (default: None)
  --dir, -d DIR         Storage directory (default: .)

Variant Filtering Options:
  --depth DEPTH         Minimum depth hard and soft cutoff specified as comma
                        separated values (default: 0,10)
  --af AF               Minimum allele frequency hard and soft cutoff
                        specified as comma separated values (default: 0,0.1)
  --strand STRAND       Minimum read number per strand hard and soft cutoff
                        specified as comma separated values (default: 0,3)
  --sv_depth, --sv-depth SV_DEPTH
                        Structural variant minimum depth hard and soft cutoff
                        specified as comma separated values (default: 0,10)
  --sv_af, --sv-af SV_AF
                        Structural variant minimum allele frequency hard
                        cutoff specified as comma separated values (default:
                        0.5,0.9)
  --sv_len, --sv-len SV_LEN
                        Structural variant maximum size hard and soft cutoff
                        specified as comma separated values (default:
                        100000,50000)

Algorithm Options:
  --mapper {bwa,minimap2,bowtie2,bwa-mem2}
                        Mapping tool to use. If you are using nanopore or
                        pacbio data it will default to minimap2 (default: bwa)
  --caller {bcftools,freebayes,gatk,pilon,lofreq,freebayes-haplotype}
                        Variant calling tool to use. (default: freebayes)
  --calling_params, --calling-params CALLING_PARAMS
                        Override default parameters for variant calling
                        (default: None)
  --kmer_counter, --kmer-counter {FastK,kmc,dsk}
                        Kmer counter (default: FastK)
  --coverage_tool, --coverage-tool {samtools,bedtools}
                        Kmer counter (default: samtools)
  --suspect             Use the suspect suite of tools to add ML predictions
                        (default: False)
  --spoligotype         Perform in-silico spoligotyping (default: False)
  --call_whole_genome, --call-whole-genome
                        Call variant across the whole genome (default: False)
  --snp_dist, --snp-dist SNP_DIST
                        Store variant set and get all samples with snp
                        distance less than this cutoff (experimental feature)
                        (default: None)
  --no_trim, --no-trim  Don't trim files using trimmomatic (default: False)
  --no_coverage_qc, --no-coverage-qc
                        Don't collect flagstats (default: False)
  --no_samclip, --no-samclip
                        Don't remove clipped reads from variant calling
                        (default: False)
  --no_delly, --no-delly
                        Don't run delly (default: False)
  --threads, -t THREADS
                        Threads to use (default: 1)
  --ram RAM             Maximum memory to use (default: 2)
  --implement_rules, --implement-rules
                        Use rules implemented in the resistance library (by
                        default only a note will be made) (default: False)

Other Options:
  --snpeff_config, --snpeff-config SNPEFF_CONFIG
                        Set the config filed used by snpEff (default: None)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --temp TEMP           Temp firectory to process all files (default: .)
  --version             show program's version number and exit
```


## tb-profiler_lineage

### Tool Description
Lineage profiling for Mycobacterium tuberculosis

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler lineage [-h] --bam BAM [--prefix PREFIX]
                           [--barcode_snps BARCODE_SNPS]
                           [--caller {bcftools,freebayes,gatk}]
                           [--kmer_counter {FastK,kmc,dsk}]
                           [--platform {illumina,nanopore,pacbio}] [--db DB]
                           [--spoligotype] [--external_db EXTERNAL_DB]
                           [--text_template TEXT_TEMPLATE] [--threads THREADS]
                           [--dir DIR] [--temp TEMP] [--db_dir DB_DIR]
                           [--version]
                           [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Options:
  -h, --help            show this help message and exit
  --bam, -a BAM         BAM file. Make sure it has been generated using the
                        H37Rv genome (GCA_000195955.2) (default: None)
  --prefix, -p PREFIX   Sample prefix (default: tbprofiler)
  --barcode_snps, --barcode-snps BARCODE_SNPS
                        Dump barcoding mutations to a file (default: None)
  --caller {bcftools,freebayes,gatk}
                        Variant caller (default: freebayes)
  --kmer_counter, --kmer-counter {FastK,kmc,dsk}
                        Kmer counter (default: FastK)
  --platform, -m {illumina,nanopore,pacbio}
                        NGS Platform used to generate data (default: illumina)
  --db DB               Mutation panel name (default: tbdb)
  --spoligotype         Perform in-silico spoligotyping (default: False)
  --external_db, --external-db EXTERNAL_DB
                        Path to db files prefix (overrides "--db" parameter)
                        (default: None)
  --text_template, --text-template TEXT_TEMPLATE
                        Jinja2 formatted template for output (default: None)
  --threads, -t THREADS
                        Threads to use (default: 1)
  --dir, -d DIR         Storage directory (default: .)
  --temp TEMP           Temp firectory to process all files (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_spoligotype

### Tool Description
Spoligotyping analysis for TBProfiler

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler spoligotype [-h] [--read1 READ1] [--read2 READ2]
                               [--bam BAM] [--fasta FASTA] [--prefix PREFIX]
                               [--txt] [--csv] [--docx]
                               [--text_template TEXT_TEMPLATE]
                               [--kmer_counter {FastK,kmc,dsk}]
                               [--platform {illumina,nanopore,pacbio}]
                               [--db DB] [--external_db EXTERNAL_DB]
                               [--dir DIR] [--threads THREADS] [--ram RAM]
                               [--temp TEMP] [--db_dir DB_DIR] [--version]
                               [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Options:
  -h, --help            show this help message and exit
  --read1, -1 READ1     First read file (default: None)
  --read2, -2 READ2     Second read file (default: None)
  --bam, -a BAM         BAM file. Make sure it has been generated using the
                        H37Rv genome (GCA_000195955.2) (default: None)
  --fasta, -f FASTA     Fasta file (default: None)
  --prefix, -p PREFIX   Sample prefix (default: tbprofiler)
  --txt                 Add text output (default: False)
  --csv                 Add CSV output (default: False)
  --docx                Add docx output. This requires docxtpl to be installed
                        (default: False)
  --text_template TEXT_TEMPLATE
                        Jinja2 formatted template for output (default: None)
  --kmer_counter, --kmer-counter {FastK,kmc,dsk}
                        Kmer counter (default: FastK)
  --platform, -m {illumina,nanopore,pacbio}
                        NGS Platform used to generate data (default: illumina)
  --db DB               Mutation panel name (default: tbdb)
  --external_db, --external-db EXTERNAL_DB
                        Path to db files prefix (overrides "--db" parameter)
                        (default: None)
  --dir, -d DIR         Storage directory (default: .)
  --threads, -t THREADS
                        Threads to use (default: 1)
  --ram RAM             Maximum memory to use in Gb (default: 2)
  --temp TEMP           Temp firectory to process all files (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_collate

### Tool Description
Collate results from TBProfiler runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
[21:14:20] INFO     Using snpEff_config file:                          db.py:738
                    /usr/local/share/tbprofiler/tbdb/snpeff/snpEff.con          
                    fig                                                         
           INFO     Using ref file:                                    db.py:738
                    /usr/local/share/tbprofiler/tbdb/genome.fasta               
           INFO     Using gff file:                                    db.py:738
                    /usr/local/share/tbprofiler/tbdb/genome.gff                 
           INFO     Using bed file:                                    db.py:738
                    /usr/local/share/tbprofiler/tbdb/genes.bed                  
           INFO     Using json_db file:                                db.py:738
                    /usr/local/share/tbprofiler/tbdb/mutations.json             
           INFO     Using variables file:                              db.py:738
                    /usr/local/share/tbprofiler/tbdb/variables.json             
           INFO     Using spoligotype_spacers file:                    db.py:738
                    /usr/local/share/tbprofiler/tbdb/spoligotype_space          
                    rs.txt                                                      
           INFO     Using spoligotype_annotations file:                db.py:738
                    /usr/local/share/tbprofiler/tbdb/spoligotype_list.          
                    csv                                                         
           INFO     Using bedmask file:                                db.py:738
                    /usr/local/share/tbprofiler/tbdb/mask.bed                   
           INFO     Using rules file:                                  db.py:738
                    /usr/local/share/tbprofiler/tbdb/rules.yml                  
           INFO     Using barcode file:                                db.py:738
                    /usr/local/share/tbprofiler/tbdb/barcode.bed                
           ERROR                                                   collate.py:82
                    ERROR: Can't find directory /results
```


## tb-profiler_reformat

### Tool Description
Sample prefix

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler reformat [-h] [--txt] [--csv] [--docx]
                            [--docx_template DOCX_TEMPLATE]
                            [--docx_plugin {default}]
                            [--text_template TEXT_TEMPLATE] [--db DB]
                            [--external_db EXTERNAL_DB] [--dir DIR]
                            [--temp TEMP] [--db_dir DB_DIR] [--version]
                            [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            json

Positional Arguments:
  json                  Sample prefix

Options:
  -h, --help            show this help message and exit
  --txt                 Add text output (default: False)
  --csv                 Add CSV output (default: False)
  --docx                Add docx output. This requires docxtpl to be installed
                        (default: False)
  --docx_template, --docx-template DOCX_TEMPLATE
                        Supply custom template for --docx output (default:
                        None)
  --docx_plugin, --docx-plugin {default}
                        Use a plugin template for --docx output (default:
                        None)
  --text_template, --text-template TEXT_TEMPLATE
                        Jinja2 formatted template for output (default: None)
  --db DB               Mutation panel name (default: tbdb)
  --external_db, --external-db EXTERNAL_DB
                        Path to db files prefix (overrides "--db" parameter)
                        (default: None)
  --dir, -d DIR         Storage directory (default: .)
  --temp TEMP           Temp firectory to process all files (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_create_db

### Tool Description
Create a database for tb-profiler

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler create_db [-h] --prefix PREFIX [--csv CSV [CSV ...]]
                             [--watchlist WATCHLIST]
                             [--spoligotypes SPOLIGOTYPES]
                             [--spoligotype_annotations SPOLIGOTYPE_ANNOTATIONS]
                             [--barcode BARCODE] [--bedmask BEDMASK]
                             [--rules RULES]
                             [--amplicon_primers AMPLICON_PRIMERS]
                             [--match_ref MATCH_REF] [--create_index]
                             [--custom] [--db_name DB_NAME]
                             [--db_commit DB_COMMIT] [--db_author DB_AUTHOR]
                             [--db_date DB_DATE] [--include_original_mutation]
                             [--load] [--no_overwrite] [--force] [--dir DIR]
                             [--db_dir DB_DIR] [--temp TEMP] [--version]
                             [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Options:
  -h, --help            show this help message and exit
  --prefix, -p PREFIX   The prefix for all output files (default: None)
  --csv, -c CSV [CSV ...]
                        The input CSV file containing the mutations (default:
                        ['mutations.csv'])
  --watchlist, -w WATCHLIST
                        A csv file containing genes to profile but without any
                        specific associated mutations (default: watchlist.csv)
  --spoligotypes SPOLIGOTYPES
                        A file containing a list of spoligotype spacers
                        (default: spoligotype_spacers.txt)
  --spoligotype_annotations, --spoligotype-annotations SPOLIGOTYPE_ANNOTATIONS
  --barcode BARCODE     A bed file containing lineage barcode SNPs (default:
                        barcode.bed)
  --bedmask BEDMASK     A bed file containing a list of low-complexity regions
                        (default: mask.bed)
  --rules RULES         A yaml file containing rules for the resistance
                        library (default: rules.yml)
  --amplicon_primers, --amplicon-primers AMPLICON_PRIMERS
                        A file containing a list of amplicon primers (default:
                        None)
  --match_ref, --match-ref MATCH_REF
                        Match the chromosome name to the given fasta file
                        (default: None)
  --create_index, --create-index
                        Create a samtools, gatk and bwa index for the
                        reference genome (default: False)
  --custom              Tells the script this is a custom database, this is
                        used to alter the generation of the version definition
                        (default: False)
  --db_name DB_NAME     Overrides the name of the database in the version file
                        (default: None)
  --db_commit, --db-commit DB_COMMIT
                        Overrides the commit string of the database in the
                        version file (default: None)
  --db_author, --db-author DB_AUTHOR
                        Overrides the author of the database in the version
                        file (default: None)
  --db_date, --db-date DB_DATE
                        Overrides the date of the database in the version file
                        (default: None)
  --include_original_mutation, --include-original-mutation
                        Include the original mutation (before reformatting) as
                        part of the variant annotaion (default: False)
  --load                Automaticaly load database (default: False)
  --no_overwrite, --no-overwrite
                        Don't load if existing database with prefix exists
                        (default: False)
  --force               Force overwrite existing database with the same name
                        (default: False)
  --dir, -d DIR         Storage directory (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --temp TEMP           Temp firectory to process all files (default: .)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_load_library

### Tool Description
Load a library into the tb-profiler database.

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler load_library [-h] [--dir DIR] [--temp TEMP]
                                [--db_dir DB_DIR] [--force] [--version]
                                [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                prefix

Positional Arguments:
  prefix                Prefix to the library files

Options:
  -h, --help            show this help message and exit
  --dir, -d DIR         Storage directory (default: .)
  --temp TEMP           Temp firectory to process all files (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --force               Force overwrite existing database with the same name
                        (default: False)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_update_tbdb

### Tool Description
Update the TB-Profiler database

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler update_tbdb [-h] [--prefix PREFIX] [--repo REPO]
                               [--branch BRANCH] [--commit COMMIT]
                               [--match_ref MATCH_REF] [--force]
                               [--db_dir DB_DIR] [--temp TEMP] [--version]
                               [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Options:
  -h, --help            show this help message and exit
  --prefix, -p PREFIX   Database name (default: None)
  --repo, -r REPO       Repository to pull from (default:
                        https://github.com/jodyphelan/tbdb.git)
  --branch, -b BRANCH   Branch to pull from (default: tbdb)
  --commit, -c COMMIT   Git commit hash to checkout (default: latest)
                        (default: None)
  --match_ref, --match-ref MATCH_REF
                        The prefix for all output files (default: None)
  --force               Force overwrite existing database with the same name
                        (default: False)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --temp TEMP           Temp firectory to process all files (default: .)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_batch

### Tool Description
Run tb-profiler on multiple samples defined in a CSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler batch [-h] --csv CSV [--args ARGS] [--jobs JOBS]
                         [--threads_per_job THREADS_PER_JOB] [--dir DIR]
                         [--db_dir DB_DIR] [--temp TEMP] [--version]
                         [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Options:
  -h, --help            show this help message and exit
  --csv CSV             CSV with samples and files (default: None)
  --args ARGS           Arguments to use with tb-profiler (default: None)
  --jobs, -j JOBS       Threads to use (default: 1)
  --threads_per_job, --threads-per-job, -t THREADS_PER_JOB
                        Threads to use (default: 1)
  --dir, -d DIR         Storage directory (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --temp TEMP           Temp firectory to process all files (default: .)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```


## tb-profiler_list_db

### Tool Description
List available databases

### Metadata
- **Docker Image**: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/TBProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/tb-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tb-profiler list_db [-h] [--dir DIR] [--temp TEMP] [--db_dir DB_DIR]
                           [--version]
                           [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Options:
  -h, --help            show this help message and exit
  --dir, -d DIR         Storage directory (default: .)
  --temp TEMP           Temp firectory to process all files (default: .)
  --db_dir DB_DIR       Database directory (default:
                        /usr/local/share/tbprofiler)
  --version             show program's version number and exit
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
```

