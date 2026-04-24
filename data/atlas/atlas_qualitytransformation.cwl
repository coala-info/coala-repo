cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - qualityTransformation
label: atlas_qualitytransformation
doc: "Printing Quality Transformation\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level
    inputBinding:
      position: 102
      prefix: --log-level
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
