cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ReverseSatsumaOut]
label: satsuma2_ReverseSatsumaOut
doc: "Swaps query and target columns in the satsuma output.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "input satsuma file"
    inputBinding:
      position: 1
      prefix: -i
outputs:
  - id: reversed
    type: stdout
    doc: "Satsuma file with query and target swapped, written to standard output"
stdout: $(inputs.input_file.nameroot).reversed.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
