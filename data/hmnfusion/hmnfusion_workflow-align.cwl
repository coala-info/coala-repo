cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - workflow-align
label: hmnfusion_workflow-align
doc: "Hmnfusion workflow for alignment of fastq files\n\nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: input_config_json
    type:
      - 'null'
      - File
    doc: Input config file
    inputBinding:
      position: 101
      prefix: --input-config-json
  - id: input_design_bed
    type:
      - 'null'
      - File
    doc: Design bed file
    inputBinding:
      position: 101
      prefix: --input-design-bed
  - id: input_forward_fastq
    type: File
    doc: Fastq file forward
    inputBinding:
      position: 101
      prefix: --input-forward-fastq
  - id: input_reverse_fastq
    type: File
    doc: Fastq file reverse
    inputBinding:
      position: 101
      prefix: --input-reverse-fastq
  - id: name
    type: string
    doc: Name of sample
    inputBinding:
      position: 101
      prefix: --name
  - id: platform
    type:
      - 'null'
      - string
    doc: Platform label to indicate into RGLINE of the BAM file
    inputBinding:
      position: 101
      prefix: --platform
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads used
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory used for temporary results
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: output_directory
    type: Directory
    doc: Directory to output
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
