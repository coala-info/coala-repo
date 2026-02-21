cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_utils
  - bam_add_tags
label: fastq_utils_bam_add_tags
doc: "Add tags to a BAM file (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils_bam_add_tags.out
