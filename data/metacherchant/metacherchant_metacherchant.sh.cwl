cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacherchant.sh
label: metacherchant_metacherchant.sh
doc: "MetaCherchant environment-finder: finds the graph environment of genomic sequences in metagenomic reads.\n\nTool homepage: https://github.com/ctlab/metacherchant"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: k
    type: int
    doc: "k-mer size (MANDATORY)"
    inputBinding:
      position: 1
      prefix: --k
  - id: reads
    type: 
      - 'null'
      - type: array
        items: File
    doc: "FASTQ, BINQ, FASTA reads (optional, default: [])"
    inputBinding:
      position: 2
      prefix: --reads
  - id: seq
    type: File
    doc: "FASTA file with sequences (MANDATORY)"
    inputBinding:
      position: 3
      prefix: --seq
  - id: output
    type: string
    doc: "output directory (MANDATORY)"
    inputBinding:
      position: 4
      prefix: --output
  - id: maxkmers
    type: 
      - 'null'
      - int
    doc: "maximum number of k-mers in created subgraph (optional)"
    inputBinding:
      position: 5
      prefix: --maxkmers
  - id: maxradius
    type: 
      - 'null'
      - int
    doc: "maximum distance in k-mers from starting gene (optional)"
    inputBinding:
      position: 6
      prefix: --maxradius
  - id: coverage
    type: 
      - 'null'
      - int
    doc: "minimum depth of k-mers to consider (optional, default: 1)"
    inputBinding:
      position: 7
      prefix: --coverage
  - id: bothdirs
    type: 
      - 'null'
      - boolean
    doc: "run graph search in both directions from starting sequence (optional)"
    inputBinding:
      position: 8
      prefix: --bothdirs
  - id: chunklength
    type: 
      - 'null'
      - int
    doc: "minimum node length for BLAST search (optional, default: 1)"
    inputBinding:
      position: 9
      prefix: --chunklength
  - id: forcehash
    type: 
      - 'null'
      - boolean
    doc: "force k-mer hashing (even for k <= 31) (optional)"
    inputBinding:
      position: 10
      prefix: --forcehash
  - id: hash
    type: 
      - 'null'
      - string
    doc: "hash function to use: poly or fnv1a (optional, default: poly)"
    inputBinding:
      position: 11
      prefix: --hash
  - id: threads
    type: 
      - 'null'
      - int
    doc: "how many java threads to use (optional, default: 32)"
    inputBinding:
      position: 12
      prefix: --threads
  - id: trim
    type: 
      - 'null'
      - boolean
    doc: "trim all not maximal paths? (optional)"
    inputBinding:
      position: 13
      prefix: --trim
  - id: memory
    type: 
      - 'null'
      - string
    doc: "memory to use (for example: 1500M, 4G, etc.) (optional, default: 2 Gb); always pass it, the wrapper script cannot detect free memory in the container"
    inputBinding:
      position: 20
      prefix: --memory
  - id: available_processors
    type: 
      - 'null'
      - int
    doc: "available processors (optional, default: all)"
    inputBinding:
      position: 21
      prefix: --available-processors
  - id: work_dir
    type: 
      - 'null'
      - string
    doc: "working directory (optional, default: workDir)"
    inputBinding:
      position: 22
      prefix: --work-dir
  - id: continue_run
    type: 
      - 'null'
      - boolean
    doc: "continue the previous run from last succeed stage, saved in working directory (optional)"
    inputBinding:
      position: 23
      prefix: --continue
  - id: force_run
    type: 
      - 'null'
      - boolean
    doc: "force run with rewriting old results (optional)"
    inputBinding:
      position: 24
      prefix: --force
  - id: start_stage
    type: 
      - 'null'
      - string
    doc: "first force run stage (with rewriting old results) (optional)"
    inputBinding:
      position: 25
      prefix: --start
  - id: finish_stage
    type: 
      - 'null'
      - string
    doc: "stop after running this stage (optional)"
    inputBinding:
      position: 26
      prefix: --finish
  - id: enable_assertions
    type: 
      - 'null'
      - boolean
    doc: "enable assertions (optional, default: assertions disabled)"
    inputBinding:
      position: 27
      prefix: --enable-assertions
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "enable debug output (optional)"
    inputBinding:
      position: 28
      prefix: --verbose
outputs:
  - id: environment
    type: Directory
    doc: "Output directory with the genomic environment of each sequence (graph, sequences, tables)"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
stdout: metacherchant.out
