cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SortSatsuma]
label: satsuma2_SortSatsuma
doc: "Sorts a Satsuma file by chr & start.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "input file"
    inputBinding:
      position: 1
      prefix: -i
outputs:
  - id: sorted
    type: stdout
    doc: "Sorted satsuma file, written to standard output"
stdout: $(inputs.input_file.nameroot).sorted.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
