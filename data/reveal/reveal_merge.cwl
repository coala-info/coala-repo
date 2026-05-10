cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal merge
label: reveal_merge
doc: "Combine multiple gfa graphs into a single gfa graph.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: graphs
    type:
      - 'null'
      - type: array
        items: File
    doc: Graphs in gfa format that should be merged.
    inputBinding:
      position: 1
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 101
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of the file to which merged graph is written.
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
