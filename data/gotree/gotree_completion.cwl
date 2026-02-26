cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - completion
label: gotree_completion
doc: "Generate the autocompletion script for gotree for the specified shell.\n\nTool
  homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The shell for which to generate the autocompletion script (bash, fish, 
      powershell, zsh)
    inputBinding:
      position: 1
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 102
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_completion.out
