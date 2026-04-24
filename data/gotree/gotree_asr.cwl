cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - asr
label: gotree_asr
doc: "Reconstructs most parsimonious ancestral sequences.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: algo
    type:
      - 'null'
      - string
    doc: 'Parsimony algorithm for resolving ambiguities: acctran, deltran, or downpass'
    inputBinding:
      position: 101
      prefix: --algo
  - id: align
    type:
      - 'null'
      - File
    doc: Alignment input file
    inputBinding:
      position: 101
      prefix: --align
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type:
      - 'null'
      - string
    doc: Input tree
    inputBinding:
      position: 101
      prefix: --input
  - id: input_strict
    type:
      - 'null'
      - boolean
    doc: Strict phylip input format (only used with -p)
    inputBinding:
      position: 101
      prefix: --input-strict
  - id: log
    type:
      - 'null'
      - string
    doc: Output log file
    inputBinding:
      position: 101
      prefix: --log
  - id: phylip
    type:
      - 'null'
      - boolean
    doc: 'Alignment is in phylip? default : false (Fasta)'
    inputBinding:
      position: 101
      prefix: --phylip
  - id: random_resolve
    type:
      - 'null'
      - boolean
    doc: 'Random resolve states when several possibilities in: acctran, deltran, or
      downpass'
    inputBinding:
      position: 101
      prefix: --random-resolve
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
