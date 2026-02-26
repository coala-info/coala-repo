cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpiphy
label: snpiphy
doc: "An automated snp phylogeny pipeline.\n\nTool homepage: https://github.com/bogemad/snpiphy"
inputs:
  - id: cov_cutoff
    type:
      - 'null'
      - int
    doc: Percent coverage of reference sequence (0-100%) used to reject a 
      sample. Samples lower than this threshold will be excluded from 
      phylogenetic pipeline steps.
    default: 85%
    inputBinding:
      position: 101
      prefix: --cov_cutoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite files in the output directories.
    inputBinding:
      position: 101
      prefix: --force
  - id: gamma_model
    type:
      - 'null'
      - boolean
    doc: Use GTRGAMMA model instead of GTRCAT during the gubbins and RAxML tree 
      building steps.
    inputBinding:
      position: 101
      prefix: --gamma_model
  - id: input_dir
    type: Directory
    doc: Path to a directory with your interleaved fastq sequencing reads, 
      single-end sequencing reads (use with the -s option) or fasta assemblies.
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: input_list
    type: File
    doc: Path to a tab-separated file containing read paths and paired status. 
      Best used when running a combination of single-end and paired-end data or 
      if your data is spread across multiple directories. Run 
      'snpiphy_generate_input_list' to generate an example list.
    inputBinding:
      position: 101
      prefix: --input_list
  - id: no_recombination_filter
    type:
      - 'null'
      - boolean
    doc: Don't filter potential recombination events. Use for organisms that are
      known undergo low amounts of recombination.
    inputBinding:
      position: 101
      prefix: --no_recombination_filter
  - id: output_directory
    type: Directory
    doc: Path to the output directory. A directory will be created if one does 
      not exist.
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: Use GNU parallel to run multiple instances of snippy (can speed things 
      up if you have multiple cores available)
    inputBinding:
      position: 101
      prefix: --parallel
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type: File
    doc: Path to the reference sequence. Only fasta format is accepted 
      currently.
    inputBinding:
      position: 101
      prefix: --reference
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: fastq reads are single end instead of paired-end. Use for ion torrent 
      or non-paired end illumina data
    inputBinding:
      position: 101
      prefix: --single_end
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for multiprocessing.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree_builder
    type:
      - 'null'
      - string
    doc: 'Algorithm used for building the phylogenetic tree (default: raxml)'
    default: raxml
    inputBinding:
      position: 101
      prefix: --tree_builder
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity on command line output (n.b. verbose output is 
      always saved to snpiphy.log in the output directory).
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpiphy:0.5--py_0
stdout: snpiphy.out
