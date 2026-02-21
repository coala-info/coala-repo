cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcnvkernel AnnotateIntervals
label: gcnvkernel_AnnotateIntervals
doc: "The provided text contains container runtime error messages rather than the
  tool's help documentation. No arguments could be extracted.\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcnvkernel:0.9--pyhdfd78af_0
stdout: gcnvkernel_AnnotateIntervals.out
