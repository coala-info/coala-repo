cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - summary
label: hotspot3d_summary
doc: "Summarize Hotspot3D clusters\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: clusters_file
    type: File
    doc: Clusters file
    inputBinding:
      position: 101
      prefix: --clusters-file
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
