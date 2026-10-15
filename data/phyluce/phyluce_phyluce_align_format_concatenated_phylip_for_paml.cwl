cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_format_concatenated_phylip_for_paml]
label: phyluce_phyluce_align_format_concatenated_phylip_for_paml
doc: "Given an input phylip file and an input config file, create a PAML-formatted file (Format #1).\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: phylip_alignment
    type: File
    doc: "The path to a PHYLIP-formatted alignment."
    inputBinding:
      position: 1
      prefix: --phylip-alignment
  - id: config
    type: File
    doc: "The path to a config file containing partition information (RAxML-formatted)."
    inputBinding:
      position: 2
      prefix: --config
  - id: output
    type: string
    doc: "The path to an output file (will be PHYLIP formatted)."
    inputBinding:
      position: 3
      prefix: --output
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 4
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 5
      prefix: --log-path
outputs:
  - id: output_phylip
    type: File
    doc: "PAML-formatted PHYLIP file."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
