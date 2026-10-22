cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scepia
  - infer_motifs
label: scepia_infer_motifs
doc: "Run SCEPIA motif inference on any scanpy-compatible file.\n\nTool homepage:
  https://github.com/vanheeringen-lab/scepia"
inputs:
  - id: infile
    type: File
    doc: Scanpy-compatible input file (for example h5ad)
    inputBinding:
      position: 1
  - id: outdir
    type: string
    doc: Output directory
    inputBinding:
      position: 2
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose matrix.
    inputBinding:
      position: 101
      prefix: --transpose
  - id: cluster
    type:
      - 'null'
      - string
    doc: cluster name (default checks for 'louvain' or 'leiden').
    inputBinding:
      position: 101
      prefix: --cluster
  - id: dataset
    type:
      - 'null'
      - string
    doc: Reference dataset (ENCODE.H3K27ac.human).
    inputBinding:
      position: 101
      prefix: --dataset
  - id: n_top_genes
    type:
      - 'null'
      - int
    doc: Maximum number of variable genes that is used (2000).
    inputBinding:
      position: 101
      prefix: --n_top_genes
  - id: pfmfile
    type:
      - 'null'
      - string
    doc: Name of motif PFM file or GimmeMotifs database name.
    inputBinding:
      position: 101
      prefix: --pfmfile
  - id: min_annotated
    type:
      - 'null'
      - int
    doc: Minimum number of cells per cell type (50).
    inputBinding:
      position: 101
      prefix: --min_annotated
  - id: num_enhancers
    type:
      - 'null'
      - int
    doc: Number of enhancers to use for motif activity (10000).
    inputBinding:
      position: 101
      prefix: --num_enhancers
outputs:
  - id: outdir_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
