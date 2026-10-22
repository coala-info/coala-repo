cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqnado
  - tools
label: seqnado_tools
doc: "List and explore bioinformatics tools available in the SeqNado pipeline.\n\nTool
  homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: tool
    type:
      - 'null'
      - string
    doc: Specific tool name to get help for (e.g., fastqc, deeptools)
    inputBinding:
      position: 1
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all available tools with descriptions
    inputBinding:
      position: 2
      prefix: --list
  - id: category
    type:
      - 'null'
      - string
    doc: Filter tools by category name or number
    inputBinding:
      position: 2
      prefix: --category
  - id: options
    type:
      - 'null'
      - boolean
    doc: Show tool options/help from the container (requires tool name and apptainer)
    inputBinding:
      position: 2
      prefix: --options
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Show the BibTeX citation for a tool (requires tool name)
    inputBinding:
      position: 2
      prefix: --citation
  - id: subcommand
    type:
      - 'null'
      - string
    doc: Specify a tool subcommand for help (e.g. plotHeatmap)
    inputBinding:
      position: 2
      prefix: --subcommand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 2
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
stdout: seqnado_tools.out
