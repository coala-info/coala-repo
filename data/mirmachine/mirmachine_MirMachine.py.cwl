cwlVersion: v1.2
class: CommandLineTool
baseCommand: MirMachine.py
label: mirmachine_MirMachine.py
doc: "Main MirMachine executable\n\nTool homepage: https://github.com/sinanugur/MirMachine"
inputs:
  - id: add_all_nodes
    type:
      - 'null'
      - boolean
    doc: Move on the tree both ways. NOT required most of the time.
    inputBinding:
      position: 101
      prefix: --add-all-nodes
  - id: cpu
    type:
      - 'null'
      - int
    doc: CPUs.
    default: 2
    inputBinding:
      position: 101
      prefix: --cpu
  - id: dry
    type:
      - 'null'
      - boolean
    doc: Dry run.
    inputBinding:
      position: 101
      prefix: --dry
  - id: evalue
    type:
      - 'null'
      - float
    doc: Inclusion E-value. May inflate low quality hits.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --evalue
  - id: family
    type:
      - 'null'
      - string
    doc: Run only a single miRNA family (e.g. Let-7).
    inputBinding:
      position: 101
      prefix: --family
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome fasta file location (e.g. data/genome/example.fasta)
    inputBinding:
      position: 101
      prefix: --genome
  - id: model
    type:
      - 'null'
      - string
    doc: 'Model type: deutero, proto, combined'
    default: combined
    inputBinding:
      position: 101
      prefix: --model
  - id: node
    type:
      - 'null'
      - string
    doc: Node name. (e.g. Caenorhabditis)
    inputBinding:
      position: 101
      prefix: --node
  - id: print_all_families
    type:
      - 'null'
      - boolean
    doc: Print all available families in this version and exit.
    inputBinding:
      position: 101
      prefix: --print-all-families
  - id: print_all_nodes
    type:
      - 'null'
      - boolean
    doc: Print all available node options and exit.
    inputBinding:
      position: 101
      prefix: --print-all-nodes
  - id: print_ascii_tree
    type:
      - 'null'
      - boolean
    doc: Print ascii tree of the tree file.
    inputBinding:
      position: 101
      prefix: --print-ascii-tree
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Clear all output files (this won't remove input files).
    inputBinding:
      position: 101
      prefix: --remove
  - id: single_node_only
    type:
      - 'null'
      - boolean
    doc: Run only on the given node for miRNA families.
    inputBinding:
      position: 101
      prefix: --single-node-only
  - id: species
    type:
      - 'null'
      - string
    doc: Species name. (e.g. Caenorhabditis_elegans)
    inputBinding:
      position: 101
      prefix: --species
  - id: touch
    type:
      - 'null'
      - boolean
    doc: Touch output files (mark them up to date without really changing them).
    inputBinding:
      position: 101
      prefix: --touch
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Rescue stalled jobs (Try this if the previous job ended prematurely).
    inputBinding:
      position: 101
      prefix: --unlock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirmachine:0.3.0.2--pyhdfd78af_0
stdout: mirmachine_MirMachine.py.out
