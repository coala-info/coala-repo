cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc_bam-aldepth
label: fuc_bam-aldepth
doc: "Count allelic depth from a BAM file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bam
    type: File
    doc: Input alignment file.
    inputBinding:
      position: 1
  - id: sites
    type: File
    doc: "TSV file containing two columns, chromosome and position. This\n       \
      \       can also be a BED or VCF file (compressed or uncompressed).\n      \
      \        Input type will be detected automatically."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bam-aldepth.out
