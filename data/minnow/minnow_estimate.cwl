cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minnow
  - estimate
label: minnow_estimate
doc: "Estimate models (BFH histogram) from alevin equivalence class output for minnow\n\nTool homepage: https://github.com/COMBINE-lab/minnow"
inputs:
  - id: eqclass_dir
    type: Directory
    doc: Directory containing relevant files produced by the python script
    inputBinding:
      position: 101
      prefix: -eq
  - id: gene_tr
    type: File
    doc: Tab separated list of gene to transcript mapping
    inputBinding:
      position: 101
      prefix: --g2t
  - id: bfh_file
    type: File
    doc: BFH file produced by alevin
    inputBinding:
      position: 101
      prefix: --bfh
  - id: cluster
    type:
      - 'null'
      - File
    doc: Optional cluster file to model cluster based histogram
    inputBinding:
      position: 101
      prefix: --cluster
  - id: out_dir_path
    type: string
    doc: Output directory; the simulated models are written here
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: out_dir
    type: Directory
    doc: The estimated models are written here
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minnow:1.2--h86b0361_0
