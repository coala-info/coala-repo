cwlVersion: v1.2
class: CommandLineTool
baseCommand: seroba summary
label: seroba_summary
doc: "writes all predictions in one tsv file\n\nTool homepage: https://github.com/sanger-pathogens/seroba"
inputs:
  - id: output_folder
    type: Directory
    doc: path to output folder with results from runSerotyping
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba_summary.out
