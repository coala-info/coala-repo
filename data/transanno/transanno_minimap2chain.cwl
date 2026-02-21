cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - minimap2chain
label: transanno_minimap2chain
doc: "Convert minimap2 result to chain file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: paf
    type: File
    doc: Input paf file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output chain file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
