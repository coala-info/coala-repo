cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia bam
label: gia_bam
doc: "BAM-centric commands\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: command
    type: string
    doc: Command to execute (convert, coverage, filter, help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
stdout: gia_bam.out
