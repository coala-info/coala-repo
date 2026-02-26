cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm merge
label: groopm_merge
doc: "Merge BAM files based on a database of alignments.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: Database name for alignment information.
    inputBinding:
      position: 1
  - id: bids
    type:
      type: array
      items: File
    doc: List of BAM files to merge.
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite if output files exist.
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_merge.out
