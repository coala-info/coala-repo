cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem_genome_stats
label: refinem_genome_stats
doc: "Calculate statistics for genomes.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: scaffold_stats_file
    type: File
    doc: file with statistics for each scaffold
    inputBinding:
      position: 1
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 1
    inputBinding:
      position: 102
      prefix: --cpus
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    default: false
    inputBinding:
      position: 102
      prefix: --silent
outputs:
  - id: output_file
    type: File
    doc: output file with genome statistics
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
