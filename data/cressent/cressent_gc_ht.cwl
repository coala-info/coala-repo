cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - gc_ht
label: cressent_gc_ht
doc: "Generate a GC content heatmap from a FASTA file.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file containing sequences."
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Sliding window size for GC content calculation (default: 30)."
    inputBinding:
      position: 101
      prefix: --window_size
  - id: step_size
    type:
      - 'null'
      - int
    doc: "Step size for GC calculation (default: 5)."
    inputBinding:
      position: 101
      prefix: --step_size
  - id: xticklabels
    type:
      - 'null'
      - int
    doc: "Interval for x-axis tick labels (default: None)."
    inputBinding:
      position: 101
      prefix: --xticklabels
  - id: fig_width
    type:
      - 'null'
      - int
    doc: "Figure width in inches (default: 12)."
    inputBinding:
      position: 101
      prefix: --fig_width
  - id: fig_height
    type:
      - 'null'
      - int
    doc: "Figure height in inches (default: 6)."
    inputBinding:
      position: 101
      prefix: --fig_height
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Name of output image file with extension (default: gc_heatmap.png)."
    inputBinding:
      position: 101
      prefix: --output_name
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
