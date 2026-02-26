cwlVersion: v1.2
class: CommandLineTool
baseCommand: igdiscover count
label: igdiscover_count
doc: "Compute expression counts\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: table
    type: File
    doc: Table with parsed and filtered IgBLAST results
    inputBinding:
      position: 1
  - id: allele_ratio
    type:
      - 'null'
      - float
    doc: 'Required allele ratio. Works only for genes named "NAME*ALLELE". Default:
      Do not check allele ratio.'
    inputBinding:
      position: 102
      prefix: --allele-ratio
  - id: d_coverage
    type:
      - 'null'
      - float
    doc: 'Minimum D coverage (in percent). Default: 70 if --gene=D, no restriction
      otherwise.'
    default: '70'
    inputBinding:
      position: 102
      prefix: --d-coverage
  - id: d_errors
    type:
      - 'null'
      - int
    doc: 'Maximum allowed D errors. Default: No limit.'
    inputBinding:
      position: 102
      prefix: --d-errors
  - id: d_evalue
    type:
      - 'null'
      - float
    doc: 'Maximal allowed E-value for D gene match. Default: 1E-4 if --gene=D, no
      restriction otherwise.'
    default: '1E-4'
    inputBinding:
      position: 102
      prefix: --d-evalue
  - id: database
    type:
      - 'null'
      - File
    doc: Compute expressions for the sequences that are named in the FASTA file.
      Only the sequence names in the file are used! This is the only way to also
      include genes with an expression of zero.
    inputBinding:
      position: 102
      prefix: --database
  - id: gene
    type:
      - 'null'
      - string
    doc: 'Which gene type: Choose V, D or J. Default: Default: V'
    default: V
    inputBinding:
      position: 102
      prefix: --gene
outputs:
  - id: plot
    type:
      - 'null'
      - File
    doc: Plot expressions to FILE (PDF or PNG)
    outputBinding:
      glob: $(inputs.plot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
