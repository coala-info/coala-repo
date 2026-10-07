cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - motif_map_viz
label: cressent_motif_map_viz
doc: "Module to plot motif analysis results (ScanProsite or MEME motifs)\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: file
    type: File
    doc: "Input file from scanprosite or motif analysis"
    inputBinding:
      position: 101
      prefix: --file
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: format
    type:
      - 'null'
      - string
    doc: "Input format: prosite, motif_table or auto (default: auto-detect)"
    inputBinding:
      position: 101
      prefix: --format
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
