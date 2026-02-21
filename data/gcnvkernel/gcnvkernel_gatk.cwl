cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcnvkernel
label: gcnvkernel_gatk
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to build a container image due to lack
  of disk space.\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcnvkernel:0.9--pyhdfd78af_0
stdout: gcnvkernel_gatk.out
