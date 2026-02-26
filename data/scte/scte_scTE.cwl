cwlVersion: v1.2
class: CommandLineTool
baseCommand: scTE
label: scte_scTE
doc: "hahaha...\n\nTool homepage: https://github.com/JiekaiLab/scTE"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input file: BAM/SAM file from CellRanger or STARsolo,\nthe file must be
      sorted by chromosome position"
    inputBinding:
      position: 1
  - id: annotation_index
    type:
      type: array
      items: File
    doc: "The filename of the index for the reference genome\nannotation."
    inputBinding:
      position: 2
  - id: genome
    type: string
    doc: '"hg38" for human, "mm10" for mouse'
    inputBinding:
      position: 3
  - id: output_prefix
    type: string
    doc: Output file prefix
    inputBinding:
      position: 4
  - id: expect_cells
    type:
      - 'null'
      - int
    doc: Expected number of cells.
    default: 10000
    inputBinding:
      position: 105
      prefix: --expect-cells
  - id: input_file_format
    type:
      - 'null'
      - string
    doc: 'Input file format: BAM or SAM. DEFAULT: BAM'
    default: BAM
    inputBinding:
      position: 105
      prefix: --format
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: "Keep the _scTEtmp file, which is useful for debugging.\nDefault: False"
    default: false
    inputBinding:
      position: 105
      prefix: --keeptmp
  - id: min_counts
    type:
      - 'null'
      - int
    doc: "Minimum number of counts required for a cell to pass\nfiltering."
    default: 2*min_genes
    inputBinding:
      position: 105
      prefix: --min_counts
  - id: min_genes
    type:
      - 'null'
      - int
    doc: "Minimum number of genes expressed required for a cell\nto pass filtering."
    default: 200
    inputBinding:
      position: 105
      prefix: --min_genes
  - id: save_hdf5
    type:
      - 'null'
      - boolean
    doc: "Save the output as .h5ad formatted file instead of csv\nfile. Default: False"
    default: false
    inputBinding:
      position: 105
      prefix: --hdf5
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use, Default: 1'
    default: 1
    inputBinding:
      position: 105
      prefix: --thread
  - id: use_cell_barcodes
    type:
      - 'null'
      - boolean
    doc: "Set to false to ignore for cell barcodes, it is useful\nfor SMART-seq. If
      you set CB=False, it also will set\nUMI=False by default, Default: True"
    default: true
    inputBinding:
      position: 105
      prefix: -CB
  - id: use_umi
    type:
      - 'null'
      - boolean
    doc: "Set to false to ignore for UMI, it is useful for\nSMART-seq. Default: True"
    default: true
    inputBinding:
      position: 105
      prefix: -UMI
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
stdout: scte_scTE.out
