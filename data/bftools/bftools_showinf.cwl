cwlVersion: v1.2
class: CommandLineTool
baseCommand: showinf
label: bftools_showinf
doc: "Bio-Formats tool to display information about image files. (Note: The provided
  text is a system error log and does not contain usage instructions; arguments could
  not be extracted from the input.)\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_showinf.out
