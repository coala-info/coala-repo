cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquamis
label: aquamis
doc: "AQUAMIS is a pipeline for the analysis of microbial communities, including assembly,
  quality control, and taxonomic profiling.\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/AQUAMIS"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler to use in shovill, choose from megahit velvet skesa spades
    inputBinding:
      position: 101
      prefix: --assembler
  - id: batch
    type:
      - 'null'
      - string
    doc: Compute sample list in batches. Please state a fraction string, e.g. 
      1/3
    inputBinding:
      position: 101
      prefix: --batch
  - id: conda_frontend
    type:
      - 'null'
      - boolean
    doc: Do not use mamba but conda as frontend to create individual conda 
      environments
    inputBinding:
      position: 101
      prefix: --conda_frontend
  - id: condaprefix
    type:
      - 'null'
      - Directory
    doc: Path of default conda environment, enables recycling of built 
      environments
    inputBinding:
      position: 101
      prefix: --condaprefix
  - id: confindr_database
    type:
      - 'null'
      - Directory
    doc: Path to ConFindR databases
    inputBinding:
      position: 101
      prefix: --confindr_database
  - id: confindr_use_rmlst
    type:
      - 'null'
      - boolean
    doc: Restrict ConFindR to use only rMLST-derived databases, even when 
      cgMLST-derived exist
    inputBinding:
      position: 101
      prefix: --confindr_use_rmlst
  - id: docker
    type:
      - 'null'
      - string
    doc: Mapped volume path of the host system
    inputBinding:
      position: 101
      prefix: --docker
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Snakemake dryrun. Only calculate graph without executing anything
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: ephemeral
    type:
      - 'null'
      - boolean
    doc: Remove most intermediate data. Analysis results are reduced to JSONs 
      and reports
    inputBinding:
      position: 101
      prefix: --ephemeral
  - id: fix_fails
    type:
      - 'null'
      - boolean
    doc: Re-run Snakemake after failure removing failed samples
    inputBinding:
      position: 101
      prefix: --fix_fails
  - id: force
    type:
      - 'null'
      - string
    doc: Snakemake force. Force recalculation of output (rule or file) specified
      here
    inputBinding:
      position: 101
      prefix: --force
  - id: forceall
    type:
      - 'null'
      - boolean
    doc: Snakemake force. Force recalculation of all steps
    inputBinding:
      position: 101
      prefix: --forceall
  - id: iontorrent
    type:
      - 'null'
      - boolean
    doc: Use single-end Ion Torrent reads as input
    inputBinding:
      position: 101
      prefix: --iontorrent
  - id: json
    type:
      - 'null'
      - boolean
    doc: Only keep assemblies and JSONs (implies --ephemeral). High-Throughput 
      mode
    inputBinding:
      position: 101
      prefix: --json
  - id: json_filter
    type:
      - 'null'
      - File
    doc: Definition of thresholds in JSON file
      /usr/local/opt/aquamis/thresholds/AQUAMIS_schema_filter_v20230906.json
    inputBinding:
      position: 101
      prefix: --json_filter
  - id: json_schema
    type:
      - 'null'
      - File
    doc: JSON schema used for validation
    inputBinding:
      position: 101
      prefix: --json_schema
  - id: kraken2db
    type:
      - 'null'
      - Directory
    doc: Path to kraken2 database
    inputBinding:
      position: 101
      prefix: --kraken2db
  - id: logdir
    type:
      - 'null'
      - Directory
    doc: Path to directory where .snakemake output is to be saved
    inputBinding:
      position: 101
      prefix: --logdir
  - id: mash_kmersize
    type:
      - 'null'
      - int
    doc: kmer size for mash, must match size of database
    inputBinding:
      position: 101
      prefix: --mash_kmersize
  - id: mash_protocol
    type:
      - 'null'
      - string
    doc: Transfer protocol for reference retrieval, choose between https or ftp
    inputBinding:
      position: 101
      prefix: --mash_protocol
  - id: mash_sketchsize
    type:
      - 'null'
      - int
    doc: sketch size for mash, must match size of database
    inputBinding:
      position: 101
      prefix: --mash_sketchsize
  - id: mashdb
    type:
      - 'null'
      - File
    doc: Path to reference mash database
    inputBinding:
      position: 101
      prefix: --mashdb
  - id: min_trimmed_length
    type:
      - 'null'
      - int
    doc: Minimum length of a read to keep
    inputBinding:
      position: 101
      prefix: --min_trimmed_length
  - id: mlst_scheme
    type:
      - 'null'
      - string
    doc: Extra option for MLST
    inputBinding:
      position: 101
      prefix: --mlst_scheme
  - id: no_assembly
    type:
      - 'null'
      - boolean
    doc: Perform only trimming and contamination assessment on reads
    inputBinding:
      position: 101
      prefix: --no_assembly
  - id: profile
    type:
      - 'null'
      - string
    doc: (A) Full path or (B) directory name under "<AQUAMIS>/profiles" of a 
      Snakemake config.yaml with Snakemake parameters, e.g. available CPUs and 
      RAM.
    inputBinding:
      position: 101
      prefix: --profile
  - id: qc_thresholds
    type:
      - 'null'
      - File
    doc: Definition of thresholds in JSON file
    inputBinding:
      position: 101
      prefix: --qc_thresholds
  - id: quast_min_contig
    type:
      - 'null'
      - int
    doc: Extra option for QUAST
    inputBinding:
      position: 101
      prefix: --quast_min_contig
  - id: quast_min_identity
    type:
      - 'null'
      - int
    doc: Extra option for QUAST
    inputBinding:
      position: 101
      prefix: --quast_min_identity
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length to be used in bracken abundance estimation
    inputBinding:
      position: 101
      prefix: --read_length
  - id: remove_temp
    type:
      - 'null'
      - boolean
    doc: Remove large temporary files. May lead to slower re-runs but saves disk
      space
    inputBinding:
      position: 101
      prefix: --remove_temp
  - id: rule_directives
    type:
      - 'null'
      - File
    doc: Process DAG with rule grouping and/or rule prioritization via Snakemake
      rule directives YAML
      directives
    inputBinding:
      position: 101
      prefix: --rule_directives
  - id: run_name
    type:
      - 'null'
      - string
    doc: Name of the sequencing run for all samples in the sample list, e.g. 
      "210401_M02387_0709_000000000-HBXX6", or a self-chosen analysis title
    inputBinding:
      position: 101
      prefix: --run_name
  - id: sample_list
    type: File
    doc: List of samples to analyze, as a three column tsv file with columns 
      sample and fastq paths. Can be generated with provided script 
      create_sampleSheet.sh
    inputBinding:
      position: 101
      prefix: --sample_list
  - id: shovill_depth
    type:
      - 'null'
      - int
    doc: Sub-sample --R1/--R2 to this depth. Disable with --depth 0
    inputBinding:
      position: 101
      prefix: --shovill_depth
  - id: shovill_extraopts
    type:
      - 'null'
      - string
    doc: 'Extra assembler options in quotes and equal sign notation e.g. spades: --shovill_extraopts="--iontorrent"'
    inputBinding:
      position: 101
      prefix: --shovill_extraopts
  - id: shovill_kmers
    type:
      - 'null'
      - string
    doc: K-mers to use <blank=AUTO>
    inputBinding:
      position: 101
      prefix: --shovill_kmers
  - id: shovill_modules
    type:
      - 'null'
      - string
    doc: 'Module options for shovill; choose from --noreadcorr --trim --nostitch --nocorr;
      Note: add choices as string in quotation marks'
    inputBinding:
      position: 101
      prefix: --shovill_modules
  - id: shovill_output_options
    type:
      - 'null'
      - string
    doc: Extra options for shovill
    inputBinding:
      position: 101
      prefix: --shovill_output_options
  - id: shovill_ram
    type:
      - 'null'
      - int
    doc: Limit amount of RAM (in GB, integer) provided to shovill
    inputBinding:
      position: 101
      prefix: --shovill_ram
  - id: shovill_tmpdir
    type:
      - 'null'
      - Directory
    doc: Fast temporary directory
    inputBinding:
      position: 101
      prefix: --shovill_tmpdir
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Use only single-end reads as input
    inputBinding:
      position: 101
      prefix: --single_end
  - id: snakefile
    type:
      - 'null'
      - File
    doc: Path to Snakefile of AQUAMIS
    inputBinding:
      position: 101
      prefix: --snakefile
  - id: taxlevel_qc
    type:
      - 'null'
      - string
    doc: Taxonomic level for kraken2 classification quality control. Choose S 
      for species or G for genus
    inputBinding:
      position: 101
      prefix: --taxlevel_qc
  - id: taxonkit_db
    type:
      - 'null'
      - Directory
    doc: Path to taxonkit_db
    inputBinding:
      position: 101
      prefix: --taxonkit_db
  - id: thread_factor
    type:
      - 'null'
      - float
    doc: Factor to increase threads_sample for shovill and quast
    inputBinding:
      position: 101
      prefix: --thread_factor
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads/Cores to use. This overrides the "<AQUAMIS>/profiles"
      settings
    inputBinding:
      position: 101
      prefix: --threads
  - id: threads_sample
    type:
      - 'null'
      - int
    doc: Number of Threads to use per sample in multi-threaded rules
    inputBinding:
      position: 101
      prefix: --threads_sample
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Unlock a Snakemake execution folder if it had been interrupted
    inputBinding:
      position: 101
      prefix: --unlock
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Utilize the Snakemake "--useconda" option, i.e. Smk rules require 
      execution with a specific conda env
    inputBinding:
      position: 101
      prefix: --use_conda
  - id: working_directory
    type: Directory
    doc: Working directory where results are saved
    inputBinding:
      position: 101
      prefix: --working_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquamis:1.4.0--hdfd78af_0
stdout: aquamis.out
