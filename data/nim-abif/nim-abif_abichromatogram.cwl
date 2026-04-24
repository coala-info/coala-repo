cwlVersion: v1.2
class: CommandLineTool
baseCommand: abichromatogram
label: nim-abif_abichromatogram
doc: "Generates an SVG chromatogram from an ABIF trace file,\ndisplaying the four
  fluorescence channels with base calls.\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs:
  - id: trace_file
    type: File
    doc: ABIF trace file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: downsample_factor
    type:
      - 'null'
      - int
    doc: Downsample factor for smoother visualization
    inputBinding:
      position: 102
      prefix: --downsample
  - id: end_pos
    type:
      - 'null'
      - int
    doc: 'End position (default: whole trace)'
    inputBinding:
      position: 102
      prefix: --end
  - id: height
    type:
      - 'null'
      - int
    doc: SVG height in pixels
    inputBinding:
      position: 102
      prefix: --height
  - id: hide_bases
    type:
      - 'null'
      - boolean
    doc: Hide base calls
    inputBinding:
      position: 102
      prefix: --hide-bases
  - id: start_pos
    type:
      - 'null'
      - int
    doc: Start position
    inputBinding:
      position: 102
      prefix: --start
  - id: width
    type:
      - 'null'
      - int
    doc: SVG width in pixels
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output SVG file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
