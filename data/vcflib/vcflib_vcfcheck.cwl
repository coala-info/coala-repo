cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfcheck
label: vcflib_vcfcheck
doc: "A tool from the vcflib suite. Note: The provided help text contains only container
  runtime error messages and does not list specific arguments or usage instructions.\n
  \nTool homepage: https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfcheck.out
