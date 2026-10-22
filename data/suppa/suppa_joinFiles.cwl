cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suppa.py
  - joinFiles
label: suppa_joinFiles
doc: "Join several PSI or TPM files into one table.\n\nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Files to be joined (space separated).
    inputBinding:
      position: 1
      prefix: --input-files
  - id: file_extension
    type: string
    doc: "Extension of the output file: psi or tpm."
    inputBinding:
      position: 1
      prefix: --file-extension
  - id: output
    type: string
    doc: Name of the output file.
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: joined
    type:
      type: array
      items: File
    doc: Joined table
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
