cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs_indelstat_sam_bam
label: pirs_indelstat_sam_bam
doc: "A tool for calculating indel statistics from SAM or BAM files. (Note: The provided
  help text appears to be a container runtime error log and does not contain usage
  information or argument definitions.)\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
stdout: pirs_indelstat_sam_bam.out
