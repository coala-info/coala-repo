cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - massdash
  - gui
label: massdash_gui
doc: "GUI for MassDash.\n\nTool homepage: https://github.com/Roestlab/massdash"
inputs:
  - id: cloud
    type:
      - 'null'
      - boolean
    doc: Set to True to emulate running on streamlit cloud, if False detect if 
      running on streamlit cloud.
    inputBinding:
      position: 101
      prefix: --cloud
  - id: perf
    type:
      - 'null'
      - boolean
    doc: Enables measuring and tracking of performance.
    inputBinding:
      position: 101
      prefix: --perf
  - id: server_port
    type:
      - 'null'
      - int
    doc: Port to run the MassDash GUI on.
    inputBinding:
      position: 101
      prefix: --server_port
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enables verbose mode.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: perf_output_path
    type: string
    doc: Name of the performance report file to writeout
    inputBinding:
      position: 102
      prefix: --perf_output
outputs:
  - id: perf_output
    type:
      - 'null'
      - File
    doc: Name of the performance report file to writeout to.
    outputBinding:
      glob: $(inputs.perf_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massdash:0.1.1--pyhdfd78af_0
