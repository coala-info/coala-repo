cwlVersion: v1.2
class: CommandLineTool
baseCommand: dr-disco detect
label: dr-disco_detect
doc: "Detects potential discoidin domains in BAM input files.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: bam_input_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: min_e_score
    type:
      - 'null'
      - int
    doc: Minimal score to initiate pulling sub-graphs (larger numbers boost 
      performance but result in suboptimal results)
    default: 8
    inputBinding:
      position: 102
      prefix: --min-e-score
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
