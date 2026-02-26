cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - mutationLoad
label: atlas_mutationload
doc: "Estimating mutation load across the genome\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) to process
    inputBinding:
      position: 2
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file for regions of interest
    inputBinding:
      position: 103
      prefix: -L
  - id: filtered_flag
    type:
      - 'null'
      - int
    doc: Filtered flag
    default: 0
    inputBinding:
      position: 103
      prefix: -F
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 0
    inputBinding:
      position: 103
      prefix: -q
  - id: required_flag
    type:
      - 'null'
      - int
    doc: Required flag
    default: 0
    inputBinding:
      position: 103
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 0
    inputBinding:
      position: 103
      prefix: -@
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
