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
    type:
      - 'null'
      - File
    doc: SPAdes assembly fasta file (mode 2, used instead of reads)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: forward_reads
    type:
      - 'null'
      - File
    doc: forward paired-end reads (mode 1)
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
      - string
    doc: output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: reverse paired-end reads (mode 1)
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
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: result directory <output directory>/<sample>_PlaScope
    outputBinding:
      glob: |
        ${ return inputs.output_directory ? inputs.output_directory + '/' + inputs.sample + '_PlaScope' : inputs.sample + '_PlaScope'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plascope:1.3.1--0
stdout: plascope_plaScope.sh.out
