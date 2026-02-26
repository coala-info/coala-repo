cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_random
label: gia_random
doc: "gia_random\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: input_file
    type: File
    doc: input file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
stdout: gia_random.out
