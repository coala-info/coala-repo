cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_utils
  - fastq_trim_poly_at
label: fastq_utils_fastq_trim_poly_at
doc: "Trim poly-A/T tails from FASTQ files. (Note: The provided help text contained
  only system error messages regarding container execution and did not list specific
  CLI arguments.)\n\nTool homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils_fastq_trim_poly_at.out
