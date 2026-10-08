cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - differentialexpression
label: ensemblcov_differentialexpression
doc: "id convert from differential expression: replaces Ensembl gene ids by gene names\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: differentialexpression
    type: File
    doc: "path to the differential expression"
    inputBinding:
      position: 1
  - id: annotation
    type: File
    doc: Gene id to gene name table (lines of <ensembl id>,<gene name>) made by gtf-annotate-generate or auto-generate; staged as the file named annotation, which the tool reads from the working directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_table
    type:
      - 'null'
      - File
    doc: "Converted differential expression table"
    outputBinding:
      glob: diffconverted.txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: annotation
        entry: $(inputs.annotation)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_differentialexpression.out
