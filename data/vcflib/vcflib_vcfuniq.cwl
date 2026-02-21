cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfuniq
label: vcflib_vcfuniq
doc: "A tool from the vcflib suite used to remove duplicate entries from a VCF file.
  (Note: The provided help text contained only system error messages and no usage
  information.)\n\nTool homepage: https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfuniq.out
