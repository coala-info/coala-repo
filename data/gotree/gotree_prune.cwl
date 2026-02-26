cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree prune
label: gotree_prune
doc: "This tool removes tips of the input reference tree that : \n\n1) Are not present
  in the compared tree (--comp <other tree>) if any or\n2) Are present in the given
  tip file (--tipfile <file>) if any or \n3) Are randomly sampled (--random <num tips>),
  accounting for diversity (--diversity) or not, or\n4) Are given on the command line\n\
  \nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: tips_on_commandline
    type:
      - 'null'
      - type: array
        items: string
    doc: Tips given on command line
    inputBinding:
      position: 1
  - id: comp
    type:
      - 'null'
      - string
    doc: Input compared tree
    default: none
    inputBinding:
      position: 102
      prefix: --comp
  - id: diversity
    type:
      - 'null'
      - boolean
    doc: If the random pruning takes into account diversity (only with --random)
    inputBinding:
      position: 102
      prefix: --diversity
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 102
      prefix: --format
  - id: random
    type:
      - 'null'
      - int
    doc: Number of tips to randomly sample
    inputBinding:
      position: 102
      prefix: --random
  - id: ref
    type:
      - 'null'
      - string
    doc: Input reference tree
    default: stdin
    inputBinding:
      position: 102
      prefix: --ref
  - id: revert
    type:
      - 'null'
      - boolean
    doc: 'If true, then revert the behavior: will keep only species given in the command
      line, or keep only the species that are specific to the input tree, or keep
      only randomly selected taxa'
    inputBinding:
      position: 102
      prefix: --revert
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
  - id: tipfile
    type:
      - 'null'
      - string
    doc: Tip file
    default: none
    inputBinding:
      position: 102
      prefix: --tipfile
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output tree
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
