cwlVersion: v1.2
class: CommandLineTool
baseCommand: plaScope.sh
label: plascope_plaScope.sh
doc: "PlaScope: A tool for plasmid detection and classification.\n\nTool homepage:
  https://github.com/GuilhemRoyer/PlaScope"
inputs:
  - id: db_dir
    type: Directory
    doc: path to centrifuge database
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: db_name
    type: string
    doc: centrifuge database name
    inputBinding:
      position: 101
      prefix: --db_name
  - id: fasta_assembly
    type: File
    doc: SPAdes assembly fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: forward_reads
    type: File
    doc: forward paired-end reads
    inputBinding:
      position: 101
      prefix: '-1'
  - id: no_banner
    type:
      - 'null'
      - boolean
    doc: don't print beautiful banners
    inputBinding:
      position: 101
      prefix: --no-banner
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reverse_reads
    type: File
    doc: reverse paired-end reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plascope:1.3.1--0
stdout: plascope_plaScope.sh.out
