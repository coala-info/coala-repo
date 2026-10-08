cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_isoform_usage
label: flair_plot_isoform_usage
doc: 'Produce two images for one gene: the isoform models and the usage proportions.
  The most highly expressed isoforms across all the samples are plotted; minor isoforms
  are aggregated into a gray bar.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix used for output files (default is the gene name)
    inputBinding:
      position: 1
      prefix: -o
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of total supporting reads for an isoform to be visualized
      (default 6)
    inputBinding:
      position: 1
      prefix: --min_reads
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF containing the isoform names that include each variant in the last sample
      column
    inputBinding:
      position: 1
      prefix: --vcf
  - id: palette
    type:
      - 'null'
      - File
    doc: Palette file with a hex colour per line, to show more than 7 isoforms or
      change the colours
    inputBinding:
      position: 1
      prefix: --palette
  - id: isoforms
    type: File
    doc: Isoforms in bed format
    inputBinding:
      position: 2
  - id: counts_matrix
    type: File
    doc: Isoform counts
    inputBinding:
      position: 3
  - id: gene_name
    type: string
    doc: Name of the gene; it must match the gene names in the isoform and counts
      files
    inputBinding:
      position: 4
outputs:
  - id: plots
    type:
      type: array
      items: File
    doc: Isoform model and usage images
    outputBinding:
      glob: $(inputs.output_prefix || inputs.gene_name)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
