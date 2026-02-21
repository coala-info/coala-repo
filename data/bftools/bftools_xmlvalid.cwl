cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlvalid
label: bftools_xmlvalid
doc: "Bio-Formats XML validation tool (Note: The provided help text contains a system
  error log and does not list command-line arguments).\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_xmlvalid.out
