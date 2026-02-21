cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_modify
label: ffindex_ffindex_modify
doc: "Modify an ffindex database (No help text provided in input)\n\nTool homepage:
  https://github.com/soedinglab/ffindex_soedinglab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_modify.out
