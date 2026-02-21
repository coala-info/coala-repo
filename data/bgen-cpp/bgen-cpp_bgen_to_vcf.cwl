cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bgen_to_vcf
label: bgen-cpp_bgen_to_vcf
doc: "A tool to convert BGEN files to VCF format. (Note: The provided help text contains
  only system error messages regarding a failed container build and does not list
  specific command-line arguments.)\n\nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp_bgen_to_vcf.out
