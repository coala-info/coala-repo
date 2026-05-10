cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy unzip
label: dimspy_unzip
doc: "Unzip a dimspy file.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: input
    type: File
    doc: file[.zip]
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Directory to write to.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
