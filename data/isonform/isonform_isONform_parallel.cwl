cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isONform_parallel
label: isonform_isONform_parallel
doc: "isONform is a tool for generating high-quality isoforms from Oxford Nanopore
  cDNA reads. (Note: The provided help text contains system error messages and does
  not list command-line arguments.)\n\nTool homepage: https://github.com/aljpetri/isONform"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonform:0.3.4--pyh7cba7a3_0
stdout: isonform_isONform_parallel.out
