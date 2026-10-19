cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytransaln
label: pytransaln_align
doc: "Translation-guided nucleotide (codon) alignment of coding sequences, with reading frame detection and stop codon screening.\n\nTool homepage: https://github.com/monagrland/pytransaln"
arguments:
  - position: 10
    valueFrom: align
inputs:
  - id: input
    type: File
    doc: 'Path to input file with unaligned nt sequences, Fasta format'
    inputBinding:
      position: 1
      prefix: --input
  - id: code
    type:
      - 'null'
      - int
    doc: 'Genetic code to use for all sequences, NCBI translation table number (except stopless codes 27, 28, 31)'
    inputBinding:
      position: 2
      prefix: --code
  - id: hmm
    type:
      - 'null'
      - File
    doc: Optional HMM to screen translated sequences; only first model will be read from file
    inputBinding:
      position: 3
      prefix: --hmm
  - id: ignore_terminal_stop
    type:
      - 'null'
      - boolean
    doc: Do not include terminal stop codon in translations
    inputBinding:
      position: 4
      prefix: --ignore_terminal_stop
  - id: out_hmmsearch_path
    type:
      - 'null'
      - string
    default: test.hmmsearch_tblout.txt
    doc: Path to write tabular output from hmmsearch
    inputBinding:
      position: 5
      prefix: --out_hmmsearch
  - id: how
    type:
      - 'null'
      - string
    doc: 'How to choose reading frame: ''each'' - find reading frame that minimizes stop codons for each individual sequence; ''cons'' - find frame that minimizes stop codons across all sequences and apply that frame to all sequences; ''user'' - user specified reading frame at option --frame'
    inputBinding:
      position: 11
      prefix: --how
  - id: maxstops
    type:
      - 'null'
      - int
    doc: 'Max stop codons to allow in ''good'' alignment; nt sequences over this threshold in all frames will be written to --out_bad'
    inputBinding:
      position: 11
      prefix: --maxstops
  - id: frame
    type:
      - 'null'
      - int
    doc: 'Reading frame offset to apply to all sequences, must be 0, 1, or 2; overridden by --how each or --how cons'
    inputBinding:
      position: 11
      prefix: --frame
  - id: aligner
    type:
      - 'null'
      - string
    doc: Alignment program to use (only MAFFT implemented at the moment)
    inputBinding:
      position: 11
      prefix: --aligner
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to pass to alignment program
    inputBinding:
      position: 11
      prefix: --threads
  - id: out_aa_path
    type:
      - 'null'
      - string
    default: test.aa.fasta
    doc: Path to write aa translations with <=MAXSTOPS stop codons
    inputBinding:
      position: 12
      prefix: --out_aa
  - id: out_bad_path
    type:
      - 'null'
      - string
    default: test.bad.nt.fasta
    doc: Path to write nt sequences with too many stop codons (putative pseudogenes)
    inputBinding:
      position: 12
      prefix: --out_bad
  - id: out_aln_aa_path
    type:
      - 'null'
      - string
    default: test.aln.aa.fasta
    doc: Path to write initial aa alignment
    inputBinding:
      position: 12
      prefix: --out_aln_aa
  - id: out_aln_nt_path
    type:
      - 'null'
      - string
    default: test.aln.nt.fasta
    doc: Path to write initial codon alignment
    inputBinding:
      position: 12
      prefix: --out_aln_nt
  - id: out_aln_nt_aug_path
    type:
      - 'null'
      - string
    default: test.aln.nt.aug.fasta
    doc: Path to write codon alignment augmented with putative pseudogenes
    inputBinding:
      position: 12
      prefix: --out_aln_nt_aug
  - id: out_bad_fs_report_path
    type:
      - 'null'
      - string
    default: test.bad.nt.frameshifts.tsv
    doc: Path to write report on likely frameshifts in putative pseudogenes
    inputBinding:
      position: 12
      prefix: --out_bad_fs_report
outputs:
  - id: out_aa
    type:
      - 'null'
      - File
    doc: Path to write aa translations with <=MAXSTOPS stop codons
    outputBinding:
      glob: $(inputs.out_aa_path)
  - id: out_bad
    type:
      - 'null'
      - File
    doc: Path to write nt sequences with too many stop codons (putative pseudogenes)
    outputBinding:
      glob: $(inputs.out_bad_path)
  - id: out_aln_aa
    type:
      - 'null'
      - File
    doc: Path to write initial aa alignment
    outputBinding:
      glob: $(inputs.out_aln_aa_path)
  - id: out_aln_nt
    type:
      - 'null'
      - File
    doc: Path to write initial codon alignment
    outputBinding:
      glob: $(inputs.out_aln_nt_path)
  - id: out_aln_nt_aug
    type:
      - 'null'
      - File
    doc: Path to write codon alignment augmented with putative pseudogenes
    outputBinding:
      glob: $(inputs.out_aln_nt_aug_path)
  - id: out_bad_fs_report
    type:
      - 'null'
      - File
    doc: Path to write report on likely frameshifts in putative pseudogenes
    outputBinding:
      glob: $(inputs.out_bad_fs_report_path)
  - id: out_hmmsearch
    type:
      - 'null'
      - File
    doc: Path to write tabular output from hmmsearch
    outputBinding:
      glob: $(inputs.out_hmmsearch_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
