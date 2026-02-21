cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - artic-tools
  - validate_scheme
label: artic-tools_validate_scheme
doc: "Validate an amplicon scheme for compliance with ARTIC standards\n\nTool homepage:
  https://github.com/will-rowe/artic-tools"
inputs:
  - id: scheme
    type: File
    doc: The primer scheme to validate
    inputBinding:
      position: 1
  - id: ref_seq
    type:
      - 'null'
      - File
    doc: The reference sequence for the primer scheme (FASTA format)
    inputBinding:
      position: 102
      prefix: --refSeq
outputs:
  - id: output_primer_seqs
    type:
      - 'null'
      - File
    doc: If provided, will write primer sequences as multiFASTA (requires --refSeq
      to be provided)
    outputBinding:
      glob: $(inputs.output_primer_seqs)
  - id: output_inserts
    type:
      - 'null'
      - File
    doc: If provided, will write primer scheme inserts as BED (exluding primer sequences)
    outputBinding:
      glob: $(inputs.output_inserts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
