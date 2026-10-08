cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - subtract
label: dr-disco_subtract
doc: "Subtract chimeric SAM/BAM alignment produced by RNA-STAR v2.6 or higher.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: input_alignment_file
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: output_alignment_file
    type: string
    doc: Output alignment file
    inputBinding:
      position: 2
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: Path in which temp files are stored
    inputBinding:
      position: 102
      prefix: --temp-dir
outputs:
  - id: out_output_alignment_file
    type: File
    doc: Output alignment file
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: '$(inputs.output_alignment_file)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
