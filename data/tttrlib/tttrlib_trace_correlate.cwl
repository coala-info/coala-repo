cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tttrlib
  - trace
  - correlate
label: tttrlib_trace_correlate
doc: "Compute correlation. Writes one .cor file per channel combination next to each input file.\n\nTool homepage: https://github.com/fluorescence-tools/tttrlib"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input photon files (for example PicoQuant PTU files)
    inputBinding:
      position: 10
  - id: fine
    type:
      - 'null'
      - boolean
    doc: Make fine correlation (with microtime). Default false.
    inputBinding:
      position: 1
      prefix: --fine
      valueFrom: '$(self ? "true" : "false")'
  - id: correlation_channel_1
    type: string
    doc: List of routing channel numbers considered in correlation channel 1, e.g. "0,1".
    inputBinding:
      position: 1
      prefix: --correlation_channel_1
  - id: correlation_channel_2
    type:
      - 'null'
      - string
    doc: List of routing channel numbers considered in correlation channel 2, e.g. "0,1". If no correlation channels are given routing channels of ch1 are used.
    inputBinding:
      position: 1
      prefix: --correlation_channel_2
  - id: n_casc
    type:
      - 'null'
      - int
    doc: Multi tau correlation parameter, number of cascades. Default 25.
    inputBinding:
      position: 1
      prefix: --n_casc
  - id: n_bins
    type:
      - 'null'
      - int
    doc: Multi tau correlation parameter, number of bins per cascade. Default 9.
    inputBinding:
      position: 1
      prefix: --n_bins
  - id: n_chunks
    type:
      - 'null'
      - int
    doc: Number of pieces the data is to be split into. Default 5.
    inputBinding:
      position: 1
      prefix: --n_chunks
  - id: join
    type:
      - 'null'
      - boolean
    doc: If true files selected by wildcard are lexically sorted and joined. Default false.
    inputBinding:
      position: 1
      prefix: --join
      valueFrom: '$(self ? "true" : "false")'
  - id: do_plot
    type:
      - 'null'
      - boolean
    doc: If true plots to a svg file.
    inputBinding:
      position: 1
      prefix: --do_plot
      valueFrom: '$(self ? "true" : "false")'
outputs:
  - id: correlations
    type:
      type: array
      items: File
    doc: Correlation curves (.cor files) and optional plot (.svg)
    outputBinding:
      glob:
        - "*.cor"
        - "*.svg"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.input)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
