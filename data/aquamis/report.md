# aquamis CWL Generation Report

## aquamis

### Tool Description
AQUAMIS is a pipeline for the analysis of microbial communities, including assembly, quality control, and taxonomic profiling.

### Metadata
- **Docker Image**: quay.io/biocontainers/aquamis:1.4.0--hdfd78af_0
- **Homepage**: https://gitlab.com/bfr_bioinformatics/AQUAMIS
- **Package**: https://anaconda.org/channels/bioconda/packages/aquamis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aquamis/overview
- **Total Downloads**: 18.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: aquamis [-h] [--sample_list SAMPLE_LIST]
               [--working_directory WORKING_DIRECTORY] [--snakefile SNAKEFILE]
               [--docker DOCKER] [--qc_thresholds QC_THRESHOLDS]
               [--json_schema JSON_SCHEMA] [--json_filter JSON_FILTER]
               [--min_trimmed_length MIN_TRIMMED_LENGTH] [--mashdb MASHDB]
               [--mash_kmersize MASH_KMERSIZE]
               [--mash_sketchsize MASH_SKETCHSIZE]
               [--mash_protocol MASH_PROTOCOL] [--kraken2db KRAKEN2DB]
               [--taxlevel_qc TAXLEVEL_QC] [--read_length READ_LENGTH]
               [--taxonkit_db TAXONKIT_DB]
               [--confindr_database CONFINDR_DATABASE]
               [--confindr_use_rmlst CONFINDR_USE_RMLST]
               [--shovill_tmpdir SHOVILL_TMPDIR] [--shovill_ram SHOVILL_RAM]
               [--shovill_depth SHOVILL_DEPTH] [--assembler ASSEMBLER]
               [--shovill_kmers SHOVILL_KMERS]
               [--shovill_extraopts SHOVILL_EXTRAOPTS]
               [--shovill_modules SHOVILL_MODULES]
               [--shovill_output_options SHOVILL_OUTPUT_OPTIONS]
               [--mlst_scheme MLST_SCHEME]
               [--quast_min_contig QUAST_MIN_CONTIG]
               [--quast_min_identity QUAST_MIN_IDENTITY] [--run_name RUN_NAME]
               [--no_assembly] [--single_end] [--iontorrent] [--ephemeral]
               [--json] [--fix_fails] [--rule_directives RULE_DIRECTIVES]
               [--use_conda] [--conda_frontend] [--condaprefix CONDAPREFIX]
               [--remove_temp] [--threads THREADS]
               [--threads_sample THREADS_SAMPLE]
               [--thread_factor THREAD_FACTOR] [--batch BATCH] [--force FORCE]
               [--forceall FORCEALL] [--profile PROFILE] [--dryrun] [--unlock]
               [--logdir LOGDIR] [--version]

optional arguments:
  -h, --help            show this help message and exit
  --sample_list SAMPLE_LIST, -l SAMPLE_LIST
                        [REQUIRED] List of samples to analyze, as a three
                        column tsv file with columns sample and fastq paths.
                        Can be generated with provided script
                        create_sampleSheet.sh
  --working_directory WORKING_DIRECTORY, -d WORKING_DIRECTORY
                        [REQUIRED] Working directory where results are saved
  --snakefile SNAKEFILE, -s SNAKEFILE
                        Path to Snakefile of AQUAMIS; default:
                        /usr/local/opt/aquamis/Snakefile
  --docker DOCKER       Mapped volume path of the host system
  --qc_thresholds QC_THRESHOLDS
                        Definition of thresholds in JSON file; default: /usr/l
                        ocal/opt/aquamis/resources/AQUAMIS_thresholds.json
  --json_schema JSON_SCHEMA
                        JSON schema used for validation; default: /usr/local/o
                        pt/aquamis/resources/AQUAMIS_schema_v20230906.json
  --json_filter JSON_FILTER
                        Definition of thresholds in JSON file; default: /usr/l
                        ocal/opt/aquamis/thresholds/AQUAMIS_schema_filter_v202
                        30906.json
  --min_trimmed_length MIN_TRIMMED_LENGTH
                        Minimum length of a read to keep; default: 15
  --mashdb MASHDB       Path to reference mash database; default:
                        /usr/local/opt/aquamis/reference_db/mash/mashDB.msh
  --mash_kmersize MASH_KMERSIZE
                        kmer size for mash, must match size of database;
                        default: 21
  --mash_sketchsize MASH_SKETCHSIZE
                        sketch size for mash, must match size of database;
                        default: 1000
  --mash_protocol MASH_PROTOCOL
                        Transfer protocol for reference retrieval, choose
                        between https or ftp; default: "https"
  --kraken2db KRAKEN2DB
                        Path to kraken2 database; default:
                        /usr/local/opt/aquamis/reference_db/kraken2
  --taxlevel_qc TAXLEVEL_QC
                        Taxonomic level for kraken2 classification quality
                        control. Choose S for species or G for genus; default:
                        "G"
  --read_length READ_LENGTH
                        Read length to be used in bracken abundance
                        estimation; default: 150
  --taxonkit_db TAXONKIT_DB
                        Path to taxonkit_db; default:
                        /usr/local/opt/aquamis/reference_db/taxonkit
  --confindr_database CONFINDR_DATABASE
                        Path to ConFindR databases; default:
                        /usr/local/opt/aquamis/reference_db/confindr
  --confindr_use_rmlst CONFINDR_USE_RMLST
                        Restrict ConFindR to use only rMLST-derived databases,
                        even when cgMLST-derived exist; default: False
  --shovill_tmpdir SHOVILL_TMPDIR
                        Fast temporary directory; default: /tmp/shovill_$USER
  --shovill_ram SHOVILL_RAM
                        Limit amount of RAM (in GB, integer) provided to
                        shovill; default: 16
  --shovill_depth SHOVILL_DEPTH
                        Sub-sample --R1/--R2 to this depth. Disable with
                        --depth 0; default: 100
  --assembler ASSEMBLER
                        Assembler to use in shovill, choose from megahit
                        velvet skesa spades; default: spades
  --shovill_kmers SHOVILL_KMERS
                        K-mers to use <blank=AUTO>; default: ""
  --shovill_extraopts SHOVILL_EXTRAOPTS
                        Extra assembler options in quotes and equal sign
                        notation e.g. spades: --shovill_extraopts="--
                        iontorrent"; default: ""
  --shovill_modules SHOVILL_MODULES
                        Module options for shovill; choose from --noreadcorr
                        --trim --nostitch --nocorr; default: --noreadcorr;
                        Note: add choices as string in quotation marks
  --shovill_output_options SHOVILL_OUTPUT_OPTIONS
                        Extra options for shovill; default: ""
  --mlst_scheme MLST_SCHEME
                        Extra option for MLST; default: ""
  --quast_min_contig QUAST_MIN_CONTIG
                        Extra option for QUAST; default: 500
  --quast_min_identity QUAST_MIN_IDENTITY
                        Extra option for QUAST; default: 80
  --run_name RUN_NAME, -r RUN_NAME
                        Name of the sequencing run for all samples in the
                        sample list, e.g.
                        "210401_M02387_0709_000000000-HBXX6", or a self-chosen
                        analysis title
  --no_assembly         Perform only trimming and contamination assessment on
                        reads
  --single_end          Use only single-end reads as input
  --iontorrent          Use single-end Ion Torrent reads as input
  --ephemeral           Remove most intermediate data. Analysis results are
                        reduced to JSONs and reports
  --json                Only keep assemblies and JSONs (implies --ephemeral).
                        High-Throughput mode
  --fix_fails           Re-run Snakemake after failure removing failed samples
  --rule_directives RULE_DIRECTIVES
                        Process DAG with rule grouping and/or rule
                        prioritization via Snakemake rule directives YAML;
                        default:
                        /usr/local/opt/aquamis/profiles/smk_directives.yaml
                        equals no directives
  --use_conda           Utilize the Snakemake "--useconda" option, i.e. Smk
                        rules require execution with a specific conda env
  --conda_frontend      Do not use mamba but conda as frontend to create
                        individual conda environments
  --condaprefix CONDAPREFIX, -c CONDAPREFIX
                        Path of default conda environment, enables recycling
                        of built environments; default:
                        /usr/local/opt/aquamis/conda_env
  --remove_temp         Remove large temporary files. May lead to slower re-
                        runs but saves disk space
  --threads THREADS, -t THREADS
                        Number of Threads/Cores to use. This overrides the
                        "<AQUAMIS>/profiles" settings
  --threads_sample THREADS_SAMPLE, -p THREADS_SAMPLE
                        Number of Threads to use per sample in multi-threaded
                        rules; default: 1
  --thread_factor THREAD_FACTOR
                        Factor to increase threads_sample for shovill and
                        quast; default: 3
  --batch BATCH, -b BATCH
                        Compute sample list in batches. Please state a
                        fraction string, e.g. 1/3
  --force FORCE, -f FORCE
                        Snakemake force. Force recalculation of output (rule
                        or file) specified here
  --forceall FORCEALL   Snakemake force. Force recalculation of all steps
  --profile PROFILE     (A) Full path or (B) directory name under
                        "<AQUAMIS>/profiles" of a Snakemake config.yaml with
                        Snakemake parameters, e.g. available CPUs and RAM.
                        Default: "bfr.hpc"
  --dryrun, -n          Snakemake dryrun. Only calculate graph without
                        executing anything
  --unlock              Unlock a Snakemake execution folder if it had been
                        interrupted
  --logdir LOGDIR       Path to directory where .snakemake output is to be
                        saved
  --version, -V         Print program version
```

