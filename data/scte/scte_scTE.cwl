cwlVersion: v1.2
class: CommandLineTool
baseCommand: scTE
label: scte_scTE
doc: "Single-cell transposable element expression: count genes and transposable elements per cell from a sorted CellRanger or STARsolo BAM file.\n\nTool homepage: https://github.com/JiekaiLab/scTE"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM/SAM file from CellRanger or STARsolo; the file must be sorted by chromosome position
    inputBinding:
      prefix: -i
  - id: annotation_index
    type:
      type: array
      items: File
    doc: The index of the reference genome annotation made by scTE_build
    inputBinding:
      prefix: -x
  - id: genome
    type: string
    doc: '"hg38" for human, "mm10" for mouse'
    inputBinding:
      prefix: -g
  - id: output_prefix
    type: string
    doc: Output file prefix
    inputBinding:
      prefix: -o
  - id: min_genes
    type: ['null', int]
    doc: 'Minimum number of genes expressed required for a cell to pass filtering. Default: 200'
    inputBinding:
      prefix: --min_genes
  - id: min_counts
    type: ['null', int]
    doc: 'Minimum number of counts required for a cell to pass filtering. Default: 2*min_genes'
    inputBinding:
      prefix: --min_counts
  - id: expect_cells
    type: ['null', int]
    doc: 'Expected number of cells. Default: 10000'
    inputBinding:
      prefix: --expect-cells
  - id: input_file_format
    type: ['null', string]
    doc: 'Input file format: BAM or SAM. Default: BAM'
    inputBinding:
      prefix: -f
  - id: use_cell_barcodes
    type: ['null', string]
    doc: 'True or False. Set to False to ignore cell barcodes, useful for SMART-seq; this also sets UMI to False by default. Default: True'
    inputBinding:
      prefix: -CB
  - id: use_umi
    type: ['null', string]
    doc: 'True or False. Set to False to ignore UMI, useful for SMART-seq. Default: True'
    inputBinding:
      prefix: -UMI
  - id: keep_tmp
    type: ['null', string]
    doc: 'True or False. Keep the _scTEtmp file, which is useful for debugging. Default: False'
    inputBinding:
      prefix: --keeptmp
  - id: save_hdf5
    type: ['null', string]
    doc: 'True or False. Save the output as .h5ad formatted file instead of csv file. Default: False'
    inputBinding:
      prefix: --hdf5
  - id: threads
    type: ['null', int]
    doc: 'Number of threads to use. Default: 1'
    inputBinding:
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type: File[]
    doc: Count table written with the output prefix (.csv, or .h5ad with --hdf5 True)
    outputBinding:
      glob: ["$(inputs.output_prefix).csv", "$(inputs.output_prefix).h5ad"]
  - id: tmp_dir
    type: ['null', Directory]
    doc: Temporary directory kept with --keeptmp True
    outputBinding:
      glob: $(inputs.output_prefix)_scTEtmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
stdout: scte_scTE.out
