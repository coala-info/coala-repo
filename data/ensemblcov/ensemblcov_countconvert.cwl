cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - countconvert
label: ensemblcov_countconvert
doc: "id convert from counts file: replaces Ensembl gene ids in a counts matrix by gene names\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: counts
    type: File
    doc: "path to the counts matrix file"
    inputBinding:
      position: 1
  - id: annotation
    type: File
    doc: Gene id to gene name table (lines of <ensembl id>,<gene name>) made by gtf-annotate-generate or auto-generate; staged as the file named annotation, which the tool reads from the working directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_counts
    type:
      - 'null'
      - File
    doc: "Counts with gene names"
    outputBinding:
      glob: countconverted.txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: annotation
        entry: $(inputs.annotation)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_countconvert.out
