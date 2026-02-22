cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoAggregate
label: crispresso2_CRISPRessoAggregate
doc: "CRISPRessoAggregate is a tool for aggregating and comparing results from multiple
  CRISPResso2 analysis runs.\n\nTool homepage: https://github.com/pinellolab/CRISPResso2"
inputs:
  - id: control_id
    type:
      - 'null'
      - string
    doc: The ID of the control sample to which other samples will be compared.
    inputBinding:
      position: 101
      prefix: --control_id
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels to use for each input folder in the aggregation plots.
    inputBinding:
      position: 101
      prefix: --labels
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the aggregation run.
    inputBinding:
      position: 101
      prefix: --name
  - id: outputs
    type:
      type: array
      items: Directory
    doc: List of output folders from CRISPResso2 runs to be aggregated.
    inputBinding:
      position: 101
      prefix: --outputs
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Folder where the aggregated results will be written.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
