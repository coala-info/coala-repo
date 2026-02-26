cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytransaln_align
label: pytransaln_align
doc: "Align nucleotide sequences and translate them to amino acids, handling reading
  frames and stop codons.\n\nTool homepage: https://github.com/monagrland/pytransaln"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: Alignment program to use (only MAFFT implemented at the moment)
    inputBinding:
      position: 101
      prefix: --aligner
  - id: frame
    type:
      - 'null'
      - int
    doc: Reading frame offset to apply to all sequences, must be 0, 1, or 2; 
      overridden by --how each or --how cons
    inputBinding:
      position: 101
      prefix: --frame
  - id: how
    type:
      - 'null'
      - string
    doc: "How to choose reading frame: 'each' - find reading frame that minimizes
      stop codons for each individual sequence; may result in more than one possible
      frame per sequence; 'cons' - find frame that minimizes stop codons across all
      sequences and apply that frame too all sequences; 'user' - user specified reading
      frame at option --frame"
    inputBinding:
      position: 101
      prefix: --how
  - id: maxstops
    type:
      - 'null'
      - int
    doc: Max stop codons to allow in 'good' alignment; nt sequences over this 
      threshold in all frames will be written to --out_bad
    inputBinding:
      position: 101
      prefix: --maxstops
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to pass to alignment program
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_aa
    type:
      - 'null'
      - File
    doc: Path to write aa translations with <=MAXSTOPS stop codons
    outputBinding:
      glob: $(inputs.out_aa)
  - id: out_bad
    type:
      - 'null'
      - File
    doc: Path to write nt sequences with too many stop codons (putative 
      pseudogenes)
    outputBinding:
      glob: $(inputs.out_bad)
  - id: out_aln_aa
    type:
      - 'null'
      - File
    doc: Path to write initial aa alignment
    outputBinding:
      glob: $(inputs.out_aln_aa)
  - id: out_aln_nt
    type:
      - 'null'
      - File
    doc: Path to write initial codon alignment
    outputBinding:
      glob: $(inputs.out_aln_nt)
  - id: out_aln_nt_aug
    type:
      - 'null'
      - File
    doc: Path to write codon alignment augmented with putative pseudogenes
    outputBinding:
      glob: $(inputs.out_aln_nt_aug)
  - id: out_bad_fs_report
    type:
      - 'null'
      - File
    doc: Path to write report on likely frameshifts in putative pseudogenes
    outputBinding:
      glob: $(inputs.out_bad_fs_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
