# ntm-profiler CWL Generation Report

## ntm-profiler_profile

### Tool Description
Profile NTM samples

### Metadata
- **Docker Image**: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/NTM-Profiler
- **Package**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Total Downloads**: 22.2K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/jodyphelan/NTM-Profiler
- **Stars**: N/A
### Original Help Text
```text
Usage: ntm-profiler profile [-h] [--version] [--no_cleanup]
                            [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--debug] [--temp TEMP] [--db_dir DB_DIR]
                            [--dir DIR] [--read1 READ1] [--read2 READ2]
                            [--bam BAM] [--fasta FASTA] [--vcf VCF]
                            [--platform {illumina,nanopore}]
                            [--resistance_db RESISTANCE_DB]
                            [--species_db SPECIES_DB] [--prefix PREFIX]
                            [--csv] [--txt] [--add_columns ADD_COLUMNS]
                            [--call_whole_genome] [--consensus]
                            [--dist_db_name DIST_DB_NAME] [--depth DEPTH]
                            [--af AF] [--strand STRAND] [--sv_depth SV_DEPTH]
                            [--sv_af SV_AF] [--sv_len SV_LEN]
                            [--min_species_relative_abundance MIN_SPECIES_RELATIVE_ABUNDANCE]
                            [--mapper {bwa,minimap2,bowtie2,bwa-mem2}]
                            [--caller {bcftools,gatk,freebayes}]
                            [--barcode_caller {mpileup,bcftools,gatk,freebayes}]
                            [--taxonomic_software {sourmash,sylph}]
                            [--kmer_counter {kmc,dsk}]
                            [--coverage_tool {bedtools,samtools}]
                            [--calling_params CALLING_PARAMS]
                            [--snp_dist SNP_DIST] [--species_only]
                            [--no_species] [--no_trim] [--no_coverage_qc]
                            [--no_clip] [--no_delly] [--no_mash]
                            [--no_samclip] [--threads THREADS] [--ram RAM]
                            [--barcode_snps BARCODE_SNPS]

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --no_cleanup          Don't remove temporary files after run (default:
                        False)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --debug               Enable debug logging (default: False)
  --temp TEMP           Temp directory to process all files (default: .)
  --db_dir DB_DIR       Storage directory (default:
                        /usr/local/share/ntm-profiler/)
  --dir, -d DIR         Storage directory (default: .)

Input Options:
  --read1, -1 READ1     First read file (default: None)
  --read2, -2 READ2     Second read file (default: None)
  --bam, -a BAM         BAM file. Make sure it has been generated using the
                        H37Rv genome (GCA_000195955.2) (default: None)
  --fasta, -f FASTA     Fasta file (default: None)
  --vcf, -v VCF         VCF file (default: None)
  --platform, -m {illumina,nanopore}
                        NGS Platform used to generate data (default: illumina)
  --resistance_db RESISTANCE_DB
                        Mutation panel name (default: None)
  --species_db SPECIES_DB
                        Mutation panel name (default: ntmdb)

Output Options:
  --prefix, -p PREFIX   Sample prefix for all results generated (default:
                        ntmprofiler)
  --csv                 Add CSV output (default: False)
  --txt                 Add text output (default: False)
  --add_columns ADD_COLUMNS
                        Add additional columns found in the mutation database
                        to the text and csv results (default: None)
  --call_whole_genome   Call whole genome (default: False)
  --consensus           Create consensus sequence (default: False)
  --dist_db_name DIST_DB_NAME
                        Default name for SNP-dist DB (default:
                        ntm-profiler-dists.db)

Variant Filtering Options:
  --depth DEPTH         Minimum depth hard and soft cutoff specified as comma
                        separated values (default: 0,10)
  --af AF               Minimum allele frequency hard and soft cutoff
                        specified as comma separated values (default: 0,0.1)
  --strand STRAND       Minimum read number per strand hard and soft cutoff
                        specified as comma separated values (default: 0,3)
  --sv_depth SV_DEPTH   Structural variant minimum depth hard and soft cutoff
                        specified as comma separated values (default: 0,10)
  --sv_af SV_AF         Structural variant minimum allele frequency hard
                        cutoff specified as comma separated values (default:
                        0.5,0.9)
  --sv_len SV_LEN       Structural variant maximum size hard and soft cutoff
                        specified as comma separated values (default:
                        100000,50000)
  --min_species_relative_abundance MIN_SPECIES_RELATIVE_ABUNDANCE
                        Minimum abundance (percent) for a species to be
                        reported in the collated output (default: 2.0)

Algorithm Options:
  --mapper {bwa,minimap2,bowtie2,bwa-mem2}
                        Mapping tool to use. If you are using nanopore data it
                        will default to minimap2 (default: bwa)
  --caller {bcftools,gatk,freebayes}
                        Variant calling tool to use (default: freebayes)
  --barcode_caller {mpileup,bcftools,gatk,freebayes}
                        Variant calling tool to use (default: mpileup)
  --taxonomic_software {sourmash,sylph}
                        Variant calling tool to use (default: sylph)
  --kmer_counter {kmc,dsk}
                        Kmer counting tool to use (default: kmc)
  --coverage_tool {bedtools,samtools}
                        Coverage tool to use (default: samtools)
  --calling_params CALLING_PARAMS
                        Override default parameters for variant calling
                        (default: None)
  --snp_dist, --snp-dist SNP_DIST
                        Store variant set and get all samples with snp
                        distance less than this cutoff (experimental feature)
                        (default: None)
  --species_only        Predict species and quit (default: False)
  --no_species          Skip species prediction (default: True)
  --no_trim             Don't trim files using trimmomatic (default: False)
  --no_coverage_qc      Don't collect coverage statistics (default: False)
  --no_clip             Don't clip reads (default: True)
  --no_delly            Don't run delly (default: False)
  --no_mash             Don't run mash if kmers speciation fails (default:
                        False)
  --no_samclip          Don't run mash if kmers speciation fails (default:
                        False)
  --threads, -t THREADS
                        Threads to use (default: 1)
  --ram RAM             Max memory to use (default: 8)

Other Options:
  --barcode_snps, --barcode-snps BARCODE_SNPS
                        Dump barcoding mutations to a file (default: None)
```


## ntm-profiler_collate

### Tool Description
Collate results from ntm-profiler runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/NTM-Profiler
- **Package**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntm-profiler collate [-h] [--version] [--no_cleanup]
                            [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--debug] [--temp TEMP] [--db_dir DB_DIR]
                            [--dir DIR] [--outfile OUTFILE]
                            [--samples SAMPLES] [--suffix SUFFIX]
                            [--format {txt,csv}]
                            [--min_species_relative_abundance MIN_SPECIES_RELATIVE_ABUNDANCE]
                            [--dist_db_name DIST_DB_NAME]
                            [--distance_cutoff DISTANCE_CUTOFF]

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --no_cleanup          Don't remove temporary files after run (default:
                        False)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --debug               Enable debug logging (default: False)
  --temp TEMP           Temp directory to process all files (default: .)
  --db_dir DB_DIR       Storage directory (default:
                        /usr/local/share/ntm-profiler/)
  --dir, -d DIR         Storage directory (default: .)
  --outfile, -o OUTFILE
                        Sample prefix (default: ntmprofiler.collate.txt)
  --samples SAMPLES     File with samples (one per line) (default: None)
  --suffix SUFFIX       Input results files suffix (default: .results.json)
  --format {txt,csv}    Output file type (default: txt)
  --min_species_relative_abundance MIN_SPECIES_RELATIVE_ABUNDANCE
                        Minimum abundance (percent) for a species to be
                        reported in the collated output (default: 2.0)
  --dist_db_name DIST_DB_NAME
                        Default name for SNP-dist DB (default:
                        ntm-profiler-dists.db)
  --distance_cutoff DISTANCE_CUTOFF
                        Cutoff for SNP distance graph output
                        (distance<=cutoff) (default: 10)
```


## ntm-profiler_update_db

### Tool Description
Update the ntm-profiler database.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/NTM-Profiler
- **Package**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntm-profiler update_db [-h] [--version] [--no_cleanup]
                              [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--debug] [--temp TEMP] [--db_dir DB_DIR]
                              [--dir DIR] [--repo REPO] [--branch BRANCH]
                              [--commit COMMIT]

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --no_cleanup          Don't remove temporary files after run (default:
                        False)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --debug               Enable debug logging (default: False)
  --temp TEMP           Temp directory to process all files (default: .)
  --db_dir DB_DIR       Storage directory (default:
                        /usr/local/share/ntm-profiler/)
  --dir, -d DIR         Storage directory (default: .)
  --repo, -r REPO       Repository to pull from (default:
                        https://github.com/pathogen-profiler/ntm-db.git)
  --branch, -b BRANCH   Storage directory (default: main)
  --commit, -c COMMIT   Git commit hash to checkout (default: latest)
                        (default: None)
```


## ntm-profiler_create_resistance_db

### Tool Description
Create a resistance database for ntm-profiler.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/NTM-Profiler
- **Package**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntm-profiler create_resistance_db [-h] [--version] [--no_cleanup]
                                         [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                         [--debug] [--temp TEMP]
                                         [--db_dir DB_DIR] [--dir DIR]
                                         --prefix PREFIX [--csv CSV] [--load]
                                         [--watchlist WATCHLIST]
                                         [--barcode BARCODE]
                                         [--match_ref MATCH_REF]
                                         [--other_annotations OTHER_ANNOTATIONS]
                                         [--custom] [--force]
                                         [--db-name DB_NAME]
                                         [--db-commit DB_COMMIT]
                                         [--db-author DB_AUTHOR]
                                         [--db-date DB_DATE]
                                         [--include_original_mutation]

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --no_cleanup          Don't remove temporary files after run (default:
                        False)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --debug               Enable debug logging (default: False)
  --temp TEMP           Temp directory to process all files (default: .)
  --db_dir DB_DIR       Storage directory (default:
                        /usr/local/share/ntm-profiler/)
  --dir, -d DIR         Storage directory (default: .)
  --prefix, -p PREFIX   The name of the database (match species name for
                        automated speciation+resistance detection) (default:
                        None)
  --csv, -c CSV         The CSV file containing mutations (default: None)
  --load                Load the library after creating it (default: False)
  --watchlist, -w WATCHLIST
                        A csv file containing genes to profile but without any
                        specific associated mutations (default:
                        gene_watchlist.csv)
  --barcode BARCODE     A bed file containing lineage barcode SNPs (default:
                        None)
  --match_ref MATCH_REF
                        The prefix for all output files (default: None)
  --other_annotations OTHER_ANNOTATIONS
                        The prefix for all output files (default: None)
  --custom              Tells the script this is a custom database, this is
                        used to alter the generation of the version file
                        (default: False)
  --force               Tells the script to force the creation of the
                        database, even if it already exists (default: False)
  --db-name DB_NAME     Overrides the name of the database in the version file
                        (default: None)
  --db-commit DB_COMMIT
                        Overrides the commit string of the database in the
                        version file (default: None)
  --db-author DB_AUTHOR
                        Overrides the author of the database in the version
                        file (default: None)
  --db-date DB_DATE     Overrides the date of the database in the version file
                        (default: None)
  --include_original_mutation
                        Include the original mutation (before reformatting) as
                        part of the variant annotaion (default: False)
```


## ntm-profiler_create_species_db

### Tool Description
Create a species database for ntm-profiler.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/NTM-Profiler
- **Package**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntm-profiler create_species_db [-h] [--version] [--no_cleanup]
                                      [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                      [--debug] [--temp TEMP]
                                      [--db_dir DB_DIR] [--dir DIR] --prefix
                                      PREFIX --sourmash_db SOURMASH_DB
                                      --accessions ACCESSIONS
                                      [--sylph_db SYLPH_DB]
                                      [--taxonomy_info TAXONOMY_INFO]
                                      [--force] [--load] [--db-name DB_NAME]
                                      [--db-commit DB_COMMIT]
                                      [--db-author DB_AUTHOR]
                                      [--db-date DB_DATE]

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --no_cleanup          Don't remove temporary files after run (default:
                        False)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --debug               Enable debug logging (default: False)
  --temp TEMP           Temp directory to process all files (default: .)
  --db_dir DB_DIR       Storage directory (default:
                        /usr/local/share/ntm-profiler/)
  --dir, -d DIR         Storage directory (default: .)
  --prefix, -p PREFIX   The name of the database (default: None)
  --sourmash_db SOURMASH_DB
                        The file containing species sourmash (default: None)
  --accessions ACCESSIONS
                        The CSV file containing map from accessions to species
                        (default: None)
  --sylph_db SYLPH_DB   The directory containing sylph sketches (default:
                        None)
  --taxonomy_info TAXONOMY_INFO
                        A CSV file containing information and notes about taxa
                        (default: None)
  --force               Tells the script to force the creation of the
                        database, even if it already exists (default: False)
  --load                Load the library after creating it (default: False)
  --db-name DB_NAME     Overrides the name of the database in the version file
                        (default: None)
  --db-commit DB_COMMIT
                        Overrides the commit string of the database in the
                        version file (default: None)
  --db-author DB_AUTHOR
                        Overrides the author of the database in the version
                        file (default: None)
  --db-date DB_DATE     Overrides the date of the database in the version file
                        (default: None)
```


## ntm-profiler_list_db

### Tool Description
List available databases

### Metadata
- **Docker Image**: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/NTM-Profiler
- **Package**: https://anaconda.org/channels/bioconda/packages/ntm-profiler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntm-profiler list_db [-h] [--version] [--no_cleanup]
                            [--logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--debug] [--temp TEMP] [--db_dir DB_DIR]
                            [--dir DIR]

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --no_cleanup          Don't remove temporary files after run (default:
                        False)
  --logging {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level (default: INFO)
  --debug               Enable debug logging (default: False)
  --temp TEMP           Temp directory to process all files (default: .)
  --db_dir DB_DIR       Storage directory (default:
                        /usr/local/share/ntm-profiler/)
  --dir, -d DIR         Storage directory (default: .)
```


## Metadata
- **Skill**: generated
