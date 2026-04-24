cwlVersion: v1.2
class: CommandLineTool
baseCommand: FasTAN
label: fastan_FasTAN
doc: "FasTAN: Fast Alignment of Nucleotide sequences\n\nTool homepage: https://github.com/thegenemyers/FASTAN"
inputs:
  - id: source_path
    type: File
    doc: Source file path with optional extension
    inputBinding:
      position: 1
  - id: target
    type: File
    doc: Target file path with optional .1aln extension
    inputBinding:
      position: 2
  - id: compute_models
    type:
      - 'null'
      - boolean
    doc: Compute models of each hit (not yet implemented).
    inputBinding:
      position: 103
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastan:0.5--h577a1d6_0
stdout: fastan_FasTAN.out
