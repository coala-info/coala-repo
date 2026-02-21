cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - +liftover
label: bcftools-liftover-plugin
doc: "Liftover VCF/BCF files using a chain file.\n\nTool homepage: https://github.com/freeseek/score"
inputs:
  - id: input_file
    type: File
    doc: Input VCF or BCF file
    inputBinding:
      position: 1
  - id: chain_file
    type: File
    doc: Chain file for liftover
    inputBinding:
      position: 102
      prefix: --map
  - id: columns
    type:
      - 'null'
      - string
    doc: Columns to update (e.g., CHROM,POS,REF,ALT)
    inputBinding:
      position: 102
      prefix: --columns
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference_fasta
    type: File
    doc: Reference FASTA file for the target assembly
    inputBinding:
      position: 102
      prefix: --fasta
outputs:
  - id: reject
    type:
      - 'null'
      - File
    doc: Write rejected records to this file
    outputBinding:
      glob: $(inputs.reject)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-liftover-plugin:1.22--hb66fcc3_0
