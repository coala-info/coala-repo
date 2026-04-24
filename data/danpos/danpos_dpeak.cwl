cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danpos.py
  - dpeak
label: danpos_dpeak
doc: "The dpeak function in DANPOS is used for calling peaks (nucleosomes) from sequencing
  data, typically after preprocessing or for specific enrichment analysis.\n\nTool
  homepage: https://sites.google.com/site/danposdoc/"
inputs:
  - id: input_paths
    type:
      type: array
      items: Directory
    doc: Path to the input files or directories containing the data.
    inputBinding:
      position: 1
  - id: background
    type:
      - 'null'
      - Directory
    doc: Path to the background files or directories.
    inputBinding:
      position: 102
      prefix: --bg
  - id: distance
    type:
      - 'null'
      - int
    doc: The minimum distance between peaks.
    inputBinding:
      position: 102
      prefix: --distance
  - id: edge
    type:
      - 'null'
      - int
    doc: The edge size for peak calling.
    inputBinding:
      position: 102
      prefix: --edge
  - id: fdr_threshold
    type:
      - 'null'
      - float
    doc: The FDR threshold for peak calling.
    inputBinding:
      position: 102
      prefix: --fdr
  - id: height_threshold
    type:
      - 'null'
      - int
    doc: The minimum height of a peak.
    inputBinding:
      position: 102
      prefix: --height
  - id: mask_file
    type:
      - 'null'
      - File
    doc: A file containing genomic regions to be masked.
    inputBinding:
      position: 102
      prefix: --mask
  - id: p_value
    type:
      - 'null'
      - float
    doc: The p-value threshold for peak calling.
    inputBinding:
      position: 102
      prefix: --pvalue
  - id: smooth
    type:
      - 'null'
      - int
    doc: The size of the smoothing window.
    inputBinding:
      position: 102
      prefix: --smooth
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The name of the output directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
