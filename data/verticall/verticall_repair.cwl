cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall repair
label: verticall_repair
doc: "repair assembly for use in Verticall\n\nTool homepage: https://github.com/rrwick/Verticall"
inputs:
  - id: in_file
    type: File
    doc: Filename of assembly in need of repair
    inputBinding:
      position: 101
      prefix: --in_file
outputs:
  - id: out_file
    type: File
    doc: "Filename of repaired assembly output (if the same as\n                 \
      \         -i, the input file will be overwritten)"
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
