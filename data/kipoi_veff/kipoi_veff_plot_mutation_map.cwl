cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - veff
  - plot_mutation_map
label: kipoi_veff_plot_mutation_map
doc: "Plot mutation map in a file.\n\nTool homepage: https://github.com/kipoi/kipoi-veff"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input HDF5 file produced from create_mutation_map."
    inputBinding:
      position: 0
      prefix: --input_file
  - id: input_entry
    type: string
    doc: "Input line for which the plot should be generated."
    inputBinding:
      position: 0
      prefix: --input_entry
  - id: model_seq_input
    type: string
    doc: "Model input name to be used for plotting, as defined in model.yaml."
    inputBinding:
      position: 0
      prefix: --model_seq_input
  - id: scoring_key
    type: string
    doc: "Variant score label to be used for plotting, as defined when running create_mutation_map."
    inputBinding:
      position: 0
      prefix: --scoring_key
  - id: model_output
    type: string
    doc: "Model output to be used for plotting, as defined in model.yaml."
    inputBinding:
      position: 0
      prefix: --model_output
  - id: limit_region_genomic
    type:
      - 'null'
      - type: array
        items: int
    doc: "Limit to a genomic region given as two positions without the chromosome, for example 13245 12347."
    inputBinding:
      position: 0
      prefix: --limit_region_genomic
  - id: rc_plot
    type:
      - 'null'
      - boolean
    doc: "Make reverse-complement plot."
    inputBinding:
      position: 0
      prefix: --rc_plot
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output image file."
    inputBinding:
      position: 0
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Mutation map image
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi_veff:0.3.1--pyh145b6a8_1
