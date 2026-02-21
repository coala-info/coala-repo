cwlVersion: v1.2
class: CommandLineTool
baseCommand: nordic
label: nordic
doc: "NOise Reduction with DIstribution Corrected (NORDIC) for MRI data. (Note: The
  provided text is an error log and does not contain usage information or argument
  definitions.)\n\nTool homepage: https://github.com/clreda/NORDic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nordic:2.7.1--py311h8ddd9a4_0
stdout: nordic.out
