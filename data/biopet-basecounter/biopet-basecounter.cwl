cwlVersion: v1.2
class: CommandLineTool
baseCommand: BaseCounter
label: biopet-basecounter
doc: "A tool for counting bases in a BAM file using a refFlat file.\n\nTool homepage:
  https://github.com/biopet/basecounter"
inputs:
  - id: bam
    type: File
    doc: Bam file. Mandatory
    inputBinding:
      position: 101
      prefix: --bam
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix for the output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ref_flat
    type: File
    doc: refFlat file. Mandatory
    inputBinding:
      position: 101
      prefix: --refFlat
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory. Mandatory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-basecounter:0.1--0
