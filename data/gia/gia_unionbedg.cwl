cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - unionbedg
label: gia_unionbedg
doc: "Combines multiple BedGraph files into a single file and shows coverage over
  segmented intervals of each BedGraph file as a separate column\n\nTool homepage:
  https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
    default: 1
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: inputs
    type:
      type: array
      items: File
    doc: Input BED files to process
    inputBinding:
      position: 101
      prefix: --inputs
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Assume *ALL* input is sorted
    default: false
    inputBinding:
      position: 101
      prefix: --sorted
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
