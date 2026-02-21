cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_utils
  - bam_umi_count
label: fastq_utils_bam_umi_count
doc: "BAM UMI count utility (Note: The provided help text contains system error messages
  and does not list usage or arguments).\n\nTool homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils_bam_umi_count.out
