cwlVersion: v1.2
class: CommandLineTool
baseCommand: ANIclustermap
label: aniclustermap_ANIclustermap
doc: "Draw ANI(Average Nucleotide Identity) clustermap\n\nTool homepage: https://github.com/moshi4/ANIclustermap/"
inputs:
  - id: annotation
    type:
      - 'null'
      - boolean
    doc: Show ANI value annotation
    inputBinding:
      position: 101
      prefix: --annotation
  - id: annotation_fmt
    type:
      - 'null'
      - string
    doc: Annotation value format
    inputBinding:
      position: 101
      prefix: --annotation_fmt
  - id: cbar_pos
    type:
      - 'null'
      - string
    doc: Colorbar position
    inputBinding:
      position: 101
      prefix: --cbar_pos
  - id: cmap_colors
    type:
      - 'null'
      - string
    doc: cmap interpolation colors parameter
    inputBinding:
      position: 101
      prefix: --cmap_colors
  - id: cmap_gamma
    type:
      - 'null'
      - float
    doc: cmap gamma parameter
    inputBinding:
      position: 101
      prefix: --cmap_gamma
  - id: cmap_ranges
    type:
      - 'null'
      - string
    doc: Range values (e.g. 80,90,95,100) for discrete cmap
    inputBinding:
      position: 101
      prefix: --cmap_ranges
  - id: dendrogram_ratio
    type:
      - 'null'
      - float
    doc: Dendrogram ratio to figsize
    inputBinding:
      position: 101
      prefix: --dendrogram_ratio
  - id: fig_height
    type:
      - 'null'
      - float
    doc: Figure height
    inputBinding:
      position: 101
      prefix: --fig_height
  - id: fig_width
    type:
      - 'null'
      - float
    doc: Figure width
    inputBinding:
      position: 101
      prefix: --fig_width
  - id: indir
    type: Directory
    doc: Input genome fasta directory (*.fa|*.fna[.gz]|*.fasta)
    inputBinding:
      position: 101
      prefix: --indir
  - id: mode
    type:
      - 'null'
      - string
    doc: ANI calculation tool (fastani|skani)
    inputBinding:
      position: 101
      prefix: --mode
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous ANI calculation result
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No print log on screen
    inputBinding:
      position: 101
      prefix: --quiet
  - id: thread_num
    type:
      - 'null'
      - int
    doc: Thread number parameter
    inputBinding:
      position: 101
      prefix: --thread_num
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aniclustermap:2.0.1--pyhdfd78af_0
