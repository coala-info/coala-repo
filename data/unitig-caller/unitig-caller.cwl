cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitig-caller
label: unitig-caller
doc: "Call unitigs in a population dataset\n\nTool homepage: https://github.com/johnlees/unitig-caller"
inputs:
  - id: call
    type:
      - 'null'
      - boolean
    doc: Build a DBG and call colours of unitigs within
    inputBinding:
      position: 101
      prefix: --call
  - id: colours
    type:
      - 'null'
      - File
    doc: Existing bifrost colours file in .bfg_colors format
    inputBinding:
      position: 101
      prefix: --colours
  - id: graph
    type:
      - 'null'
      - File
    doc: Existing graph in GFA format
    inputBinding:
      position: 101
      prefix: --graph
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size for graph building/querying
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer
  - id: no_save_idx
    type:
      - 'null'
      - boolean
    doc: Do not save FM-indexes for reuse
    inputBinding:
      position: 101
      prefix: --no-save-idx
  - id: out
    type:
      - 'null'
      - string
    doc: Prefix for output
    default: unitig_caller
    inputBinding:
      position: 101
      prefix: --out
  - id: pyseer
    type:
      - 'null'
      - boolean
    doc: Output pyseer format
    inputBinding:
      position: 101
      prefix: --pyseer
  - id: query
    type:
      - 'null'
      - boolean
    doc: Query unitig colours in reference genomes/DBG
    inputBinding:
      position: 101
      prefix: --query
  - id: reads
    type:
      - 'null'
      - File
    doc: Read file to used to build DBG
    inputBinding:
      position: 101
      prefix: --reads
  - id: refs
    type:
      - 'null'
      - File
    doc: Ref file to used to build DBG or use with --simple
    inputBinding:
      position: 101
      prefix: --refs
  - id: rtab
    type:
      - 'null'
      - boolean
    doc: Output rtab format
    inputBinding:
      position: 101
      prefix: --rtab
  - id: simple
    type:
      - 'null'
      - boolean
    doc: Use FM-index to make calls
    inputBinding:
      position: 101
      prefix: --simple
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: unitigs
    type:
      - 'null'
      - File
    doc: Text or fasta file of unitigs to query (--query or --simple)
    inputBinding:
      position: 101
      prefix: --unitigs
  - id: write_graph
    type:
      - 'null'
      - boolean
    doc: Output DBG built with unitig-caller
    inputBinding:
      position: 101
      prefix: --write-graph
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-caller:1.3.1--py311heec5c76_1
stdout: unitig-caller.out
