cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter-stage-1.prl
label: repeatscout_filter-stage-1.prl
doc: "a first stage post-processing tool for RepeatScout output.\n\nTool homepage:
  https://github.com/Dfam-consortium/RepeatScout"
inputs:
  - id: input_file
    type: File
    doc: Input repeat library (Fasta-formatted sequence file)
    inputBinding:
      position: 1
  - id: dustmasker_command
    type:
      - 'null'
      - string
    doc: Path to the dustmasker executable. If not set, dustmasker must be in 
      PATH.
    inputBinding:
      position: 102
  - id: trf_command
    type:
      - 'null'
      - string
    doc: Path to the TRF executable. If not set, TRF must be in PATH.
    inputBinding:
      position: 102
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Filtered repeat library (Fasta-formatted sequence file)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
