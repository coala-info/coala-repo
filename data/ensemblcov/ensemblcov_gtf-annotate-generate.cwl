cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - gtf-annotate-generate
label: ensemblcov_gtf-annotate-generate
doc: "gtf file for annotation: writes the gene id to gene name table (annotation) from a GENCODE GTF file\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: gtf
    type: File
    doc: "path to the gtf file"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: annotation_table
    type:
      - 'null'
      - File
    doc: "Gene id to gene name table"
    outputBinding:
      glob: annotation
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_gtf-annotate-generate.out
