cwlVersion: v1.2
class: CommandLineTool
baseCommand: buildlib
label: megagta_buildlib
doc: "Build a library from read files.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: read_lib_file
    type: File
    doc: Input read library file
    inputBinding:
      position: 1
  - id: out_prefix
    type: string
    doc: Output prefix for library files
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_buildlib.out
