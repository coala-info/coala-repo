cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SatsumaToGFF]
label: satsuma2_SatsumaToGFF
doc: "Generates a GFF3 file from a satsuma file.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "input satsuma file"
    inputBinding:
      position: 1
      prefix: -i
  - id: target_coordinates
    type: ['null', boolean]
    doc: "output coordinates based on target (def=0)"
    inputBinding:
      position: 2
      prefix: -t
outputs:
  - id: gff
    type: stdout
    doc: "GFF3 file, written to standard output"
stdout: $(inputs.input_file.nameroot).gff3
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
