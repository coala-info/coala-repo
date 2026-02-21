cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcffilter
label: vcflib_vcffilter
doc: "A tool from the vcflib suite for filtering VCF files. (Note: The provided help
  text contains a container execution error rather than the tool's help documentation.)\n
  \nTool homepage: https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcffilter.out
