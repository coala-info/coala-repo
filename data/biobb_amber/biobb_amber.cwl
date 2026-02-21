cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_amber
label: biobb_amber
doc: "BioBB (BioExcel Building Blocks) adapter for the AmberTools suite. Note: The
  provided text contains build logs and a fatal error (no space left on device) rather
  than the tool's help documentation.\n\nTool homepage: https://github.com/bioexcel/biobb_amber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_amber:5.2.0--pyhdfd78af_0
stdout: biobb_amber.out
