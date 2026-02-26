cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-agg-wps
label: finaletoolkit_agg-bw
doc: "Aggregates a bigWig signal over constant-length intervals defined in a BED file.\n\
  \nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: A bigWig file containing signals over the intervals specified in 
      interval file.
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: Path to a BED file containing intervals over which signals were 
      calculated over.
    inputBinding:
      position: 2
  - id: mean
    type:
      - 'null'
      - boolean
    doc: use mean instead
    inputBinding:
      position: 103
      prefix: --mean
  - id: median_window_size
    type:
      - 'null'
      - int
    doc: Size of the median filter window used to aggregate scores. Set to 120 
      if aggregating WPS signals.
    inputBinding:
      position: 103
      prefix: --median-window-size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A wiggle file containing the aggregate signal over the intervals 
      specified in interval file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
