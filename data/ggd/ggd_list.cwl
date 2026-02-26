cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd list
label: ggd_list
doc: "Get a list of ggd data packages installed in the current or specified conda
  prefix/environment.\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: pattern
    type:
      - 'null'
      - string
    doc: (Optional) pattern to match the name of the ggd data package.
    inputBinding:
      position: 101
      prefix: --pattern
  - id: prefix
    type:
      - 'null'
      - string
    doc: (Optional) The name or the full directory path to a conda environment 
      where a ggd recipe is stored. (Only needed if listing data files not in 
      the current environment)
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_list.out
