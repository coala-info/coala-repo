cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_utils
  - fastq_pre_barcodes
label: fastq_utils_fastq_pre_barcodes
doc: "The provided text does not contain help information; it contains system error
  messages regarding container image retrieval (no space left on device).\n\nTool
  homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils_fastq_pre_barcodes.out
