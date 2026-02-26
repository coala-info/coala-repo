cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler_ls
label: cooler_ls
doc: "List all coolers inside a file.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: File
    doc: Path to the cooler file
    inputBinding:
      position: 1
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: Long listing format
    inputBinding:
      position: 102
      prefix: --long
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_ls.out
