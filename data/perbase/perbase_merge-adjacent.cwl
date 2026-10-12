cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perbase
  - merge-adjacent
label: perbase_merge-adjacent
doc: "Merge adjacent intervals that have the same depth. Input must be sorted like:
  `sort -k1,1 -k2,2n in.bed > in.sorted.bed`\n\nTool homepage: https://github.com/sstadick/perbase"
inputs:
  - id: in_file
    type: File
    doc: Input bed-like file (<chrom> <start> <stop> <depth>, with or without a header)
    inputBinding:
      position: 1
  - id: bgzip
    type:
      - 'null'
      - boolean
    doc: Optionally bgzip the output
    inputBinding:
      position: 102
      prefix: --bgzip
  - id: compression_level
    type:
      - 'null'
      - int
    doc: The level to use for compressing output (specified by --bgzip)
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: The number of threads to use for compressing output (specified by --bgzip)
    inputBinding:
      position: 102
      prefix: --compression-threads
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Indicate if the input file does not have a header
    inputBinding:
      position: 102
      prefix: --no-header
  - id: output_path
    type: string
    doc: The output location
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Merged intervals
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perbase:1.2.0--h15397dd_0
