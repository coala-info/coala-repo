cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropkick_qc
label: dropkick_qc
doc: "Quality control for single-cell RNA-seq data.\n\nTool homepage: https://github.com/KenLauLab/dropkick"
inputs:
  - id: counts
    type: File
    doc: Input (cell x gene) counts matrix as .h5ad or tab delimited text file
    inputBinding:
      position: 1
  - id: min_genes
    type:
      - 'null'
      - int
    doc: Minimum number of genes detected to keep cell. Default 50.
    inputBinding:
      position: 102
      prefix: --min-genes
  - id: n_ambient
    type:
      - 'null'
      - int
    doc: Number of top genes by dropout rate to use for ambient profile. Default
      10.
    inputBinding:
      position: 102
      prefix: --n-ambient
  - id: quietly
    type:
      - 'null'
      - boolean
    doc: Run without printing processing updates to console.
    inputBinding:
      position: 102
      prefix: --quietly
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory. Output will be placed in 
      [output-dir]/[name]_dropkick.h5ad. Default './'.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropkick:1.2.8--py310h7eb0018_0
