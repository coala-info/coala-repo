cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - generate_protein_fasta
label: pvacseq_generate_protein_fasta
doc: "Generate a protein FASTA file from a VEP-annotated VCF for pVACseq analysis.\n\
  \nTool homepage: https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: input_file
    type: File
    doc: A VEP-annotated single-sample VCF containing transcript, Wildtype 
      protein sequence, and Downstream protein sequence information
    inputBinding:
      position: 1
  - id: peptide_sequence_length
    type: int
    doc: Length of the peptide sequence to use when creating the FASTA.
    inputBinding:
      position: 2
  - id: downstream_sequence_length
    type:
      - 'null'
      - string
    doc: Cap to limit the downstream sequence length for frameshifts when 
      creating the fasta file. Use 'full' to include the full downstream 
      sequence.
    inputBinding:
      position: 103
      prefix: --downstream-sequence-length
outputs:
  - id: output_file
    type: File
    doc: The output fasta file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
