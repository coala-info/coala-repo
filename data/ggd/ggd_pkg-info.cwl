cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd pkg-info
label: ggd_pkg-info
doc: "Get the information for a specific ggd data package installed in the current\n\
  conda environment\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: name
    type: string
    doc: the name of the recipe to get info about
    inputBinding:
      position: 1
  - id: channel
    type:
      - 'null'
      - string
    doc: "The ggd channel of the recipe to list info about\n                     \
      \   (Default = genomics)"
    inputBinding:
      position: 102
      prefix: --channel
  - id: prefix
    type:
      - 'null'
      - string
    doc: "(Optional) The name or the full directory path to a\n                  \
      \      conda environment where a ggd recipe is stored. (Only\n             \
      \           needed if listing pkg data info for a pkg not\n                \
      \        installed in the current environment)"
    inputBinding:
      position: 102
      prefix: --prefix
  - id: show_recipe
    type:
      - 'null'
      - boolean
    doc: "(Optional) When the flag is set, the recipe will be\n                  \
      \      printed to the stdout. This will provide info on where\n            \
      \            the data is hosted and how it was processed. (NOTE:\n         \
      \               -sr flag does not accept arguments)"
    inputBinding:
      position: 102
      prefix: --show_recipe
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_pkg-info.out
