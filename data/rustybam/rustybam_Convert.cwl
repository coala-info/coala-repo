cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam
label: rustybam_Convert
doc: "A command-line tool for manipulating BAM files.\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_Convert.out
