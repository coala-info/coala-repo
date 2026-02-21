cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gcnvkernel
  - PreprocessIntervals
label: gcnvkernel_PreprocessIntervals
doc: "Preprocess intervals for germline copy number variant calling. (Note: The provided
  input text contained system error messages regarding container execution and did
  not include the tool's help documentation.)\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcnvkernel:0.9--pyhdfd78af_0
stdout: gcnvkernel_PreprocessIntervals.out
