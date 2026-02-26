cwlVersion: v1.2
class: CommandLineTool
baseCommand: phist
label: phist
doc: "CSV file with assignments of phages to their most probable hosts\n\nTool homepage:
  https://github.com/refresh-bio/PHIST"
inputs:
  - id: input
    type: File
    doc: "CSV file in a sparse format with a number of common k-mers between phages
      and bacteria\n\t        (result of running `kmer-db new2all -sparse phages.db
      bacteria.list`)"
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: CSV file with assignments of phages to their most probable hosts
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phist:1.0.0--py311h2de2dd3_1
