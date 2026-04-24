cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-mutator
label: snp-mutator
doc: "Generate a mutated genome by adding substitutions, insertions, and deletions
  to a reference FASTA file.\n\nTool homepage: https://github.com/CFSAN-Biostatistics/snp-mutator"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file to be mutated
    inputBinding:
      position: 1
  - id: num_deletions
    type:
      - 'null'
      - int
    doc: Number of deletions to perform
    inputBinding:
      position: 102
      prefix: --num-dels
  - id: num_insertions
    type:
      - 'null'
      - int
    doc: Number of insertions to perform
    inputBinding:
      position: 102
      prefix: --num-ins
  - id: num_substitutions
    type:
      - 'null'
      - int
    doc: Number of substitutions to perform
    inputBinding:
      position: 102
      prefix: --num-subs
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Path to the output mutated FASTA file
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Path to the output VCF file containing the mutations
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-mutator:1.2.0--pyh24bf2e0_0
