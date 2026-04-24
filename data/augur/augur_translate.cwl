cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur translate
label: augur_translate
doc: "Translate gene regions from nucleotides to amino acids. Translates nucleotide\n\
  sequences of nodes in a tree to amino acids for gene regions of the annotated\n\
  features of the provided reference sequence. Each node then gets assigned a\nlist
  of amino acid mutations for any position that has a mismatch between its\nown amino
  acid sequence and its parent's sequence. The reference amino acid\nsequences, genome
  annotations, and node amino acid mutations are output to a\nnode-data JSON file.
  .. note:: The mutation positions in the node-data JSON\nare one-based.\n\nTool homepage:
  https://github.com/nextstrain/augur"
inputs:
  - id: ancestral_sequences
    type: File
    doc: "JSON (fasta input) or VCF (VCF input) containing\nancestral and tip sequences"
    inputBinding:
      position: 101
      prefix: --ancestral-sequences
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: genes to translate (list or file containing list)
    inputBinding:
      position: 101
      prefix: --genes
  - id: reference_sequence
    type: File
    doc: GenBank or GFF file containing the annotation
    inputBinding:
      position: 101
      prefix: --reference-sequence
  - id: skip_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of input/output files, equivalent to 
      --validation-mode=skip. Use at your own risk!
    inputBinding:
      position: 101
      prefix: --skip-validation
  - id: tree
    type:
      - 'null'
      - File
    doc: prebuilt Newick -- no tree will be built if provided
    inputBinding:
      position: 101
      prefix: --tree
  - id: validation_mode
    type:
      - 'null'
      - string
    doc: Control if optional validation checks are performed and what happens if
      they fail. 'error' and 'warn' modes perform validation and emit messages 
      about failed validation checks. 'error' mode causes a non- zero exit 
      status if any validation checks failed, while 'warn' does not. 'skip' mode
      performs no validation. Note that some validation checks are non- optional
      and as such are not affected by this setting.
    inputBinding:
      position: 101
      prefix: --validation-mode
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: fasta file of the sequence the VCF was mapped to
    inputBinding:
      position: 101
      prefix: --vcf-reference
outputs:
  - id: output_node_data
    type:
      - 'null'
      - File
    doc: name of JSON file to save aa-mutations to
    outputBinding:
      glob: $(inputs.output_node_data)
  - id: alignment_output
    type:
      - 'null'
      - File
    doc: "write out translated gene alignments. If a VCF-input, a .vcf or .vcf.gz
      will be output here (depending on file ending). If fasta-input, specify the
      file name like so: 'my_alignment_%GENE.fasta', where '%GENE' will be replaced
      by the name of the gene"
    outputBinding:
      glob: $(inputs.alignment_output)
  - id: vcf_reference_output
    type:
      - 'null'
      - File
    doc: fasta file where reference sequence translations for VCF input will be 
      written
    outputBinding:
      glob: $(inputs.vcf_reference_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
