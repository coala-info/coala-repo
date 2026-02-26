cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboraptor export-bed-fasta
label: riboraptor_export-bed-fasta
doc: "Export gene level fasta from specified bed regions\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: chrom_sizes
    type: File
    doc: Path to chrom.sizes
    inputBinding:
      position: 101
      prefix: --chrom_sizes
  - id: fasta
    type: File
    doc: Path to fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: ignore_tx_version
    type:
      - 'null'
      - boolean
    doc: Ignore version (.xyz) in gene names
    inputBinding:
      position: 101
      prefix: --ignore_tx_version
  - id: offset_3p
    type:
      - 'null'
      - int
    doc: Number of downstream bases to count(3')
    inputBinding:
      position: 101
      prefix: --offset_3p
  - id: offset_5p
    type:
      - 'null'
      - int
    doc: Number of upstream bases to count(5')
    inputBinding:
      position: 101
      prefix: --offset_5p
  - id: region_bed
    type: File
    doc: Path to bed file
    inputBinding:
      position: 101
      prefix: --region_bed
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Path to write output
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
