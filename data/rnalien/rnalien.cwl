cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAlien
label: rnalien
doc: "RNAlien is a tool for the construction of RNA family models. It automatically collects sequences, performs structural alignments, and creates covariance models.\n\nTool homepage: https://github.com/eggzilla/RNAlien"
inputs:
  - id: input_fasta_file
    type:
      - 'null'
      - File
    doc: Path to input fasta file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_alignment_file
    type:
      - 'null'
      - File
    doc: Path to input alignment file
    inputBinding:
      position: 101
      prefix: -p
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Path to output directory. Default: current working directory'
    inputBinding:
      position: 101
      prefix: -o
  - id: input_tax_id
    type:
      - 'null'
      - int
    doc: NCBI taxonomy ID number of input RNA organism
    inputBinding:
      position: 101
      prefix: -t
  - id: nsci_cutoff
    type:
      - 'null'
      - float
    doc: 'Only candidate sequences with a normalized structure conservation index (nSCI) higher than this value are accepted. Default: 1'
    inputBinding:
      position: 101
      prefix: -z
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: 'Evalue cutoff for cmsearch filtering. Default: 0.001'
    inputBinding:
      position: 101
      prefix: -e
  - id: blast_database
    type:
      - 'null'
      - string
    doc: 'Specify name of blast database to use, in offline mode the filepath to the blast database (/home/user/nt_v5). Default: nt'
    inputBinding:
      position: 101
      prefix: -b
  - id: length_filter
    type:
      - 'null'
      - boolean
    doc: 'Filter blast hits per genomic length. Default: True'
    inputBinding:
      position: 101
      prefix: -l
  - id: coverage_filter
    type:
      - 'null'
      - boolean
    doc: 'Filter blast hits by coverage of at least 80%. Default: True'
    inputBinding:
      position: 101
      prefix: -a
  - id: single_hit_per_tax
    type:
      - 'null'
      - boolean
    doc: 'Only the best blast hit per taxonomic entry is considered. Default: False'
    inputBinding:
      position: 101
      prefix: -s
  - id: blast_softmasking
    type:
      - 'null'
      - boolean
    doc: 'Toggles blast query softmasking, meaning masking of non-conserved regions on the query. Default: False'
    inputBinding:
      position: 101
      prefix: -f
  - id: query_selection_method
    type:
      - 'null'
      - string
    doc: 'Method for selection of queries (filtering,clustering). Default: filtering'
    inputBinding:
      position: 101
      prefix: -m
  - id: query_number
    type:
      - 'null'
      - int
    doc: 'Number of queries used for candidate search. Default: 5'
    inputBinding:
      position: 101
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of available cpu slots/cores. Default: 1'
    inputBinding:
      position: 101
      prefix: -c
  - id: taxonomy_restriction
    type:
      - 'null'
      - string
    doc: 'Restrict search space to taxonomic kingdom (bacteria,archea,eukaryia,cellularorganisms,viruses). Default: not set'
    inputBinding:
      position: 101
      prefix: -r
  - id: session_identificator
    type:
      - 'null'
      - string
    doc: Optional session id that is used instead of automatically generated one.
    inputBinding:
      position: 101
      prefix: -d
  - id: perform_evaluation
    type:
      - 'null'
      - boolean
    doc: 'Perform evaluation step. Default: True'
    inputBinding:
      position: 101
      prefix: -x
  - id: check_setup
    type:
      - 'null'
      - boolean
    doc: 'Just prints installed tool versions and performs connection check. Default: False'
    inputBinding:
      position: 101
      prefix: -g
  - id: taxonomy_dump_path
    type:
      - 'null'
      - Directory
    doc: Path to NCBI taxonomy dump directory.
    inputBinding:
      position: 101
      prefix: -w
  - id: offline_mode
    type:
      - 'null'
      - boolean
    doc: 'Uses locally installed blast and databases. Default: False'
    inputBinding:
      position: 101
      prefix: -j
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.output_path ? {class: "Directory", basename: inputs.output_path, listing: []} : null)'
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalien:1.8.0--1
stdout: rnalien.out
