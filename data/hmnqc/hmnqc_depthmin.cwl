cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnqc
  - depthmin
label: hmnqc_depthmin
doc: "Calculate minimal depth coverage for QC reporting\n\nTool homepage: https://github.com/guillaume-gricourt/HmnQc"
inputs:
  - id: input_sample_bam
    type: File
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
  - id: parameter_cut_off
    type:
      - 'null'
      - int
    doc: Minimal CutOff Depth to report
    inputBinding:
      position: 101
      prefix: --parameter-cut-off
outputs:
  - id: output_hmnqc_xlsx
    type: File
    doc: Excel output
    outputBinding:
      glob: $(inputs.output_hmnqc_xlsx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
