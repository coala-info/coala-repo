cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refinem
  - modify_bin
label: refinem_modify_bin
doc: "Modify scaffolds in a single bin.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: scaffold_file
    type: File
    doc: scaffolds binned to generate putative genomes
    inputBinding:
      position: 1
  - id: genome_file
    type: File
    doc: genome to be modified
    inputBinding:
      position: 2
  - id: add
    type:
      - 'null'
      - type: array
        items: string
    doc: ID of scaffold to add to genome (may specify multiple times)
    inputBinding:
      position: 103
      prefix: --add
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of scaffold to allow it to be added to a genome
    inputBinding:
      position: 103
      prefix: --min_len
  - id: outlier_file
    type:
      - 'null'
      - File
    doc: remove all scaffolds identified as outliers (see outlier command)
    inputBinding:
      position: 103
      prefix: --outlier_file
  - id: remove
    type:
      - 'null'
      - type: array
        items: string
    doc: ID of scaffold to remove from bin (may specify multiple times)
    inputBinding:
      position: 103
      prefix: --remove
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: output_genome
    type: File
    doc: modified genome
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
