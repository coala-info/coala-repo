cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnqc
  - depthtarget
label: hmnqc_depthtarget
doc: "Calculate depth on target regions for BAM files using a BED file\n\nTool homepage:
  https://github.com/guillaume-gricourt/HmnQc"
inputs:
  - id: input_sample_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Bam file
    inputBinding:
      position: 101
      prefix: --input-sample-bam
  - id: input_sample_bed
    type: File
    doc: Bed File
    inputBinding:
      position: 101
      prefix: --input-sample-bed
  - id: parameter_mode
    type:
      - 'null'
      - string
    doc: Concatenate between genes ? (target or gene)
    inputBinding:
      position: 101
      prefix: --parameter-mode
  - id: parameter_threads
    type:
      - 'null'
      - int
    doc: Threads used
    inputBinding:
      position: 101
      prefix: --parameter-threads
outputs:
  - id: output_hmnqc_xlsx
    type: File
    doc: Xlsx output
    outputBinding:
      glob: $(inputs.output_hmnqc_xlsx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
