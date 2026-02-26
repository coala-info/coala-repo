cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - maf-maf2vcf
label: fuc_maf-maf2vcf
doc: "Convert a MAF file to a VCF file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: maf_file
    type: File
    doc: MAF file (compressed or uncompressed).
    inputBinding:
      position: 1
  - id: cols
    type:
      - 'null'
      - type: array
        items: string
    doc: Column(s) in the MAF file.
    inputBinding:
      position: 102
      prefix: --cols
  - id: fasta
    type:
      - 'null'
      - File
    doc: FASTA file (required to include INDELs in the output).
    inputBinding:
      position: 102
      prefix: --fasta
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: Use this flag to exclude INDELs from the output.
    inputBinding:
      position: 102
      prefix: --ignore_indels
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Name(s) to be displayed in the FORMAT field.
    inputBinding:
      position: 102
      prefix: --names
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_maf-maf2vcf.out
