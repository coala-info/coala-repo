cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar_remove
label: traitar_remove
doc: "remove phenotypes from a given phenotype archive\n\nTool homepage: http://github.com/aweimann/traitar"
inputs:
  - id: archive_f
    type: File
    doc: phenotype model archive file, which shall be modified
    inputBinding:
      position: 1
  - id: phenotypes
    type:
      type: array
      items: string
    doc: phenotypes to be removed
    inputBinding:
      position: 2
  - id: keep
    type:
      - 'null'
      - boolean
    doc: instead of remove the given phenotypes keep them and forget the rest
    inputBinding:
      position: 103
      prefix: --keep
outputs:
  - id: out_f
    type: File
    doc: out file for the modified phenotype tar archive
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
