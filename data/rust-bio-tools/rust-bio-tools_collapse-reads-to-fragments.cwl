cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - collapse-reads-to-fragments
label: rust-bio-tools_collapse-reads-to-fragments
doc: "Tool to predict maximum likelihood fragment sequence from FASTQ or BAM files.\n\
  \nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (bam or fastq)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_collapse-reads-to-fragments.out
