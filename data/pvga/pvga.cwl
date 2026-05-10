cwlVersion: v1.2
class: CommandLineTool
baseCommand: pvga
label: pvga
doc: "Perform graph-based sequence assembly.\n\nTool homepage: https://github.com/SoSongzhi/PVGA"
inputs:
  - id: backbone
    type: File
    doc: Backbone sequence file for graph construction (in fasta format).
    inputBinding:
      position: 101
      prefix: --backbone
  - id: iterations
    type:
      - 'null'
      - int
    doc: Maximum Number of Iterations for graph construction.
    inputBinding:
      position: 101
      prefix: --iterations
  - id: reads
    type: File
    doc: Reads file for graph construction (in fasta format).
    inputBinding:
      position: 101
      prefix: --reads
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Outdir
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvga:0.1.2--pyh7e72e81_0
