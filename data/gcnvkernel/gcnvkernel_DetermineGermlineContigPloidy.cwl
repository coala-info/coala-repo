cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcnvkernel DetermineGermlineContigPloidy
label: gcnvkernel_DetermineGermlineContigPloidy
doc: "Determine germline contig ploidy (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcnvkernel:0.9--pyhdfd78af_0
stdout: gcnvkernel_DetermineGermlineContigPloidy.out
