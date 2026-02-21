cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_logitModel.py
label: cpat_make_logitModel
doc: "Build a logistic regression model using training data (coding and non-coding
  sequences) to be used by CPAT for coding potential assessment.\n\nTool homepage:
  https://cpat.readthedocs.io/en/latest/"
inputs:
  - id: coding_file
    type: File
    doc: Coding sequence file (FASTA format).
    inputBinding:
      position: 101
      prefix: --coding
  - id: gene_file
    type:
      - 'null'
      - File
    doc: Training samples (coding sequences and noncoding sequences) in BED format
      or mRNA sequences in FASTA format.
    inputBinding:
      position: 101
      prefix: --gene
  - id: noncoding_file
    type: File
    doc: Non-coding sequence file (FASTA format).
    inputBinding:
      position: 101
      prefix: --noncoding
  - id: ref_genome
    type: File
    doc: Reference genome (FASTA format).
    inputBinding:
      position: 101
      prefix: --ref
outputs:
  - id: output_file
    type: File
    doc: Output logit model (RData format).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpat:3.0.5--py312hc9302aa_4
