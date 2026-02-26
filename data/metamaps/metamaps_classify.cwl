cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamaps_classify
label: metamaps_classify
doc: "Classify contigs based on sequence identity and length.\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
inputs:
  - id: db
    type: string
    doc: Path to DB
    inputBinding:
      position: 101
      prefix: --DB
  - id: mappings
    type: string
    doc: Path to mappings file
    inputBinding:
      position: 101
      prefix: --mappings
  - id: minreads
    type:
      - 'null'
      - int
    doc: Minimum number of reads per contig to be considered for fitting 
      identity and length for the 'Unknown' functionality
    inputBinding:
      position: 101
      prefix: --minreads
  - id: threads
    type:
      - 'null'
      - int
    doc: count of threads for parallel execution
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
stdout: metamaps_classify.out
