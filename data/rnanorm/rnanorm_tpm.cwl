cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - tpm
label: rnanorm_tpm
doc: "Compute TPM.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type:
      - 'null'
      - string
    doc: Input experiment data
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite already existing output file
    inputBinding:
      position: 102
      prefix: --force
  - id: gene_lengths
    type:
      - 'null'
      - File
    doc: File with gene lengths
    inputBinding:
      position: 102
      prefix: --gene-lengths
  - id: gtf
    type:
      - 'null'
      - File
    doc: Compute gene lengths from this GTF file
    inputBinding:
      position: 102
      prefix: --gtf
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output results in this file instead of stdout
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
