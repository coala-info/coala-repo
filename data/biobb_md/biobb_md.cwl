cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_md
label: biobb_md
doc: "BioBB (BioExcel Building Blocks) Molecular Dynamics module. Note: The provided
  input text appears to be a system error log (no space left on device) rather than
  a help menu, so specific arguments could not be extracted.\n\nTool homepage: https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0
stdout: biobb_md.out
