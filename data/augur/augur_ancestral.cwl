cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur ancestral
label: augur_ancestral
doc: "Infer ancestral sequences based on a tree. The ancestral sequences are inferred
  using TreeTime. Each internal node gets assigned a nucleotide sequence that maximizes
  a likelihood on the tree given its descendants and its parent node. Each node then
  gets assigned a list of nucleotide mutations for any position that has a mismatch
  between its own sequence and its parent's sequence. The node sequences and mutations
  are output to a node-data JSON file. If amino acid options are provided, the ancestral
  amino acid sequences for each requested gene are inferred with the same method as
  the nucleotide sequences described above. The inferred amino acid mutations will
  be included in the output node-data JSON file, with the format equivalent to the
  output of augur translate. The nucleotide and amino acid sequences are inferred
  separately in this command, which can potentially result in mismatches between the
  nucleotide and amino acid mutations. If you want amino acid mutations based on the
  inferred nucleotide sequences, please use augur translate. .. note:: The mutation
  positions in the node-data JSON are one-based.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: alignment in FASTA or VCF format
    inputBinding:
      position: 101
      prefix: --alignment
  - id: annotation
    type:
      - 'null'
      - File
    doc: GenBank or GFF file containing the annotation
    inputBinding:
      position: 101
      prefix: --annotation
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: genes to translate (list or file containing list)
    inputBinding:
      position: 101
      prefix: --genes
  - id: infer_ambiguous
    type:
      - 'null'
      - boolean
    doc: infer nucleotides at ambiguous (N,W,R,..) sites on tip sequences and 
      replace with most likely state.
    inputBinding:
      position: 101
      prefix: --infer-ambiguous
  - id: inference
    type:
      - 'null'
      - string
    doc: calculate joint or marginal maximum likelihood ancestral sequence 
      states
    inputBinding:
      position: 101
      prefix: --inference
  - id: keep_ambiguous
    type:
      - 'null'
      - boolean
    doc: do not infer nucleotides at ambiguous (N) sites on tip sequences (leave
      as N).
    inputBinding:
      position: 101
      prefix: --keep-ambiguous
  - id: keep_overhangs
    type:
      - 'null'
      - boolean
    doc: do not infer nucleotides for gaps (-) on either side of the alignment
    inputBinding:
      position: 101
      prefix: --keep-overhangs
  - id: root_sequence
    type:
      - 'null'
      - File
    doc: '[FASTA alignment only] file of the sequence that is used as root for mutation
      calling. Differences between this sequence and the inferred root will be reported
      as mutations on the root branch.'
    inputBinding:
      position: 101
      prefix: --root-sequence
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generation
    inputBinding:
      position: 101
      prefix: --seed
  - id: skip_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of input/output files, equivalent to 
      --validation-mode=skip. Use at your own risk!
    inputBinding:
      position: 101
      prefix: --skip-validation
  - id: translations
    type:
      - 'null'
      - File
    doc: translated alignments for each CDS/Gene. Currently only supported for 
      FASTA-input. Specify the file name via a template like 
      'aa_sequences_%GENE.fasta' where %GENE will be replaced by the gene name.
    inputBinding:
      position: 101
      prefix: --translations
  - id: tree
    type: File
    doc: prebuilt Newick
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
    doc: '[VCF alignment only] file of the sequence the VCF was mapped to. Differences
      between this sequence and the inferred root will be reported as mutations on
      the root branch.'
    inputBinding:
      position: 101
      prefix: --vcf-reference
outputs:
  - id: output_node_data
    type:
      - 'null'
      - File
    doc: name of JSON file to save mutations and ancestral sequences to
    outputBinding:
      glob: $(inputs.output_node_data)
  - id: output_sequences
    type:
      - 'null'
      - File
    doc: name of FASTA file to save ancestral nucleotide sequences to (FASTA 
      alignments only)
    outputBinding:
      glob: $(inputs.output_sequences)
  - id: output_translations
    type:
      - 'null'
      - File
    doc: name of the FASTA file(s) to save ancestral amino acid sequences to. 
      Specify the file name via a template like 
      'ancestral_aa_sequences_%GENE.fasta' where %GENE will be replaced bythe 
      gene name.
    outputBinding:
      glob: $(inputs.output_translations)
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: name of output VCF file which will include ancestral seqs
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
