cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-filter
label: hts-nim-tools_bam-filter
doc: "A tool for filtering BAM/CRAM files (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/brentp/hts-nim-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hts-nim-tools:0.3.11--hbeb723e_0
stdout: hts-nim-tools_bam-filter.out
