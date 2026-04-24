cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamm make
label: bamm_make
doc: "make a BAM/TAM file (sorted + indexed)\n\nTool homepage: https://github.com/Ecogenomics/BamM"
inputs:
  - id: alignment_algorithm
    type:
      - 'null'
      - string
    doc: "algorithm bwa uses for alignment 'mem', 'bwasw' or 'aln' (default: mem)"
    inputBinding:
      position: 101
      prefix: --alignment_algorithm
  - id: coupled
    type:
      - 'null'
      - type: array
        items: File
    doc: 'map paired sequence files (as many sets as you like) EX: -c reads1_1.fq.gz
      reads1_2.fq.gz reads2_1.fna reads2_2.fna'
    inputBinding:
      position: 101
      prefix: --coupled
  - id: database
    type: File
    doc: contigs to map onto (in fasta format)
    inputBinding:
      position: 101
      prefix: --database
  - id: extras
    type:
      - 'null'
      - string
    doc: extra arguments to use during mapping. Format is 
      "<BWA_MODE1>:'<ARGS>',<BWA_MODE2>:'<ARGS>'"
    inputBinding:
      position: 101
      prefix: --extras
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwriting of index files if they are present
    inputBinding:
      position: 101
      prefix: --force
  - id: index_algorithm
    type:
      - 'null'
      - string
    doc: algorithm bwa uses for indexing 'bwtsw' or 'is' [None for auto]
    inputBinding:
      position: 101
      prefix: --index_algorithm
  - id: interleaved
    type:
      - 'null'
      - type: array
        items: File
    doc: 'map interleaved sequence files (as many as you like) EX: -i reads1_interleaved.fq.gz
      reads2_interleaved.fna'
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep all generated database index files (see also --kept)
    inputBinding:
      position: 101
      prefix: --keep
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: Keep unmapped reads in BAM output
    inputBinding:
      position: 101
      prefix: --keep_unmapped
  - id: kept
    type:
      - 'null'
      - boolean
    doc: assume database indices already exist (e.g. previously this script was 
      run with -k/--keep)
    inputBinding:
      position: 101
      prefix: --kept
  - id: memory
    type:
      - 'null'
      - string
    doc: maximum amount of memory to use per samtools sort thread (default 2GB).
      Suffix K/M/G recognized
    inputBinding:
      position: 101
      prefix: --memory
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: 'write to this folder (default: .)'
    inputBinding:
      position: 101
      prefix: --out_folder
  - id: output_tam
    type:
      - 'null'
      - boolean
    doc: output TAM file instead of BAM file
    inputBinding:
      position: 101
      prefix: --output_tam
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to apply to BAM/TAM files (None for reference name)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress output from the mapper
    inputBinding:
      position: 101
      prefix: --quiet
  - id: show_commands
    type:
      - 'null'
      - boolean
    doc: show all commands being run
    inputBinding:
      position: 101
      prefix: --show_commands
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress all output
    inputBinding:
      position: 101
      prefix: --silent
  - id: single
    type:
      - 'null'
      - type: array
        items: File
    doc: 'map Single ended sequence files (as many as you like) EX: -s reads1_singles.fq.gz
      reads2_singles.fna'
    inputBinding:
      position: 101
      prefix: --single
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: temporary directory for working with BAM files (default do not use)
    inputBinding:
      position: 101
      prefix: --temporary_directory
  - id: threads
    type:
      - 'null'
      - int
    doc: 'maximum number of threads to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
stdout: bamm_make.out
