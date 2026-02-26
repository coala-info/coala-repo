cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - generate-length
label: transcov_generate-length
doc: "Generate transcript lengths from BAM and BED files.\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Input BED file
    inputBinding:
      position: 2
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum transcript length to consider
    inputBinding:
      position: 103
      prefix: --max-length
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
