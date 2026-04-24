cwlVersion: v1.2
class: CommandLineTool
baseCommand: mini_assemble
label: pomoxis_mini_assemble
doc: "Assemble fastq/fasta formatted reads and perform POA consensus.\n\nTool homepage:
  https://github.com/nanoporetech/pomoxis"
inputs:
  - id: error_correct
    type:
      - 'null'
      - string
    doc: "error correct longest e% of reads prior to assembly, or an estimated coverage
      (e.g. 2x).\n        For an estimated coverage, the -l option must be a fastx
      or a length (e.g. 4.8mb)."
    inputBinding:
      position: 101
      prefix: -e
  - id: input_fastq
    type: File
    doc: fastx input reads (required).
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: 'keep intermediate files (default: delete).'
    inputBinding:
      position: 101
      prefix: -k
  - id: log_commands
    type:
      - 'null'
      - boolean
    doc: log all commands before running.
    inputBinding:
      position: 101
      prefix: -x
  - id: minimap_k_option
    type:
      - 'null'
      - string
    doc: "minimap's -K option (default: 500M)."
    inputBinding:
      position: 101
      prefix: -K
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'output folder (default: assm).'
    inputBinding:
      position: 101
      prefix: -o
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'output file prefix (default: reads).'
    inputBinding:
      position: 101
      prefix: -p
  - id: racon_rounds
    type:
      - 'null'
      - int
    doc: 'number of racon rounds (default: 4).'
    inputBinding:
      position: 101
      prefix: -m
  - id: racon_shuffles
    type:
      - 'null'
      - int
    doc: 'number of racon shuffles (default: 1. If not 1, should be >10).'
    inputBinding:
      position: 101
      prefix: -n
  - id: racon_window_length
    type:
      - 'null'
      - int
    doc: 'racon window length (default: 500).'
    inputBinding:
      position: 101
      prefix: -w
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference fasta for reference-guided consensus (instead of de novo 
      assembly)
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_length
    type:
      - 'null'
      - string
    doc: Reference length, either as a number (e.g. 4.8mb) or fastx from which 
      length will be calculated.
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of minimap and racon threads (default: 1).'
    inputBinding:
      position: 101
      prefix: -t
  - id: trim_adapters
    type:
      - 'null'
      - boolean
    doc: trim adapters from reads prior to everything else.
    inputBinding:
      position: 101
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_mini_assemble.out
