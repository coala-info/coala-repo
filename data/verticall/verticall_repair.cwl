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
  - id: out_file_path
    type: string
    inputBinding:
      position: 102
      prefix: --out_file
outputs:
  - id: out_file
    type: File
    doc: "Filename of repaired assembly output (if the same as\n                 \
      \         -i, the input file will be overwritten)"
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
