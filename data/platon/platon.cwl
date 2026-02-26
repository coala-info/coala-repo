cwlVersion: v1.2
class: CommandLineTool
baseCommand: platon
label: platon
doc: "Identification and characterization of bacterial plasmid contigs from short-read
  draft assemblies.\n\nTool homepage: https://github.com/oschwengers/platon"
inputs:
  - id: genome
    type: File
    doc: draft genome in fasta format
    inputBinding:
      position: 1
  - id: characterize
    type:
      - 'null'
      - boolean
    doc: deactivate filters; characterize all contigs
    inputBinding:
      position: 102
      prefix: --characterize
  - id: db
    type:
      - 'null'
      - Directory
    doc: database path
    default: <platon_path>/db
    inputBinding:
      position: 102
      prefix: --db
  - id: meta
    type:
      - 'null'
      - boolean
    doc: use metagenome gene prediction mode
    inputBinding:
      position: 102
      prefix: --meta
  - id: mode
    type:
      - 'null'
      - string
    doc: 'applied filter mode: sensitivity: RDS only (>= 95% sensitivity); specificity:
      RDS only (>=99.9% specificity); accuracy: RDS & characterization heuristics
      (highest accuracy)'
    default: accuracy
    inputBinding:
      position: 102
      prefix: --mode
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: number of available CPUs
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/platon:1.7--pyhdfd78af_0
