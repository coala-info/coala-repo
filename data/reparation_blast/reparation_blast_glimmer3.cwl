cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmer3
label: reparation_blast_glimmer3
doc: "Read DNA sequences in <sequence-file> and predict genes\nin them using the Interpolated
  Context Model in <icm-file>.\nOutput details go to file <tag>.detail and predictions
  go to\nfile <tag>.predict\n\nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
inputs:
  - id: sequence_file
    type: File
    doc: File containing DNA sequences
    inputBinding:
      position: 1
  - id: icm_file
    type: File
    doc: Interpolated Context Model file
    inputBinding:
      position: 2
  - id: tag
    type: string
    doc: Tag for output files
    inputBinding:
      position: 3
  - id: entropy
    type:
      - 'null'
      - File
    doc: Filename for entropy profiles
    inputBinding:
      position: 104
      prefix: --entropy
  - id: extend
    type:
      - 'null'
      - boolean
    doc: Allow orfs extending off ends of sequence to be scored
    inputBinding:
      position: 104
      prefix: --extend
  - id: first_codon
    type:
      - 'null'
      - boolean
    doc: Use first codon in orf as start codon
    inputBinding:
      position: 104
      prefix: --first_codon
  - id: gc_percent
    type:
      - 'null'
      - float
    doc: GC percentage of independent model
    inputBinding:
      position: 104
      prefix: --gc_percent
  - id: gene_len
    type:
      - 'null'
      - int
    doc: Minimum gene length
    inputBinding:
      position: 104
      prefix: --gene_len
  - id: ignore
    type:
      - 'null'
      - File
    doc: Filename specifying regions of bases that are off limits
    inputBinding:
      position: 104
      prefix: --ignore
  - id: ignore_score_len
    type:
      - 'null'
      - int
    doc: Do not use the initial score filter on any gene <n> or more base long
    inputBinding:
      position: 104
      prefix: --ignore_score_len
  - id: linear
    type:
      - 'null'
      - boolean
    doc: Assume linear rather than circular genome
    inputBinding:
      position: 104
      prefix: --linear
  - id: max_olap
    type:
      - 'null'
      - int
    doc: Maximum overlap length to ignore
    inputBinding:
      position: 104
      prefix: --max_olap
  - id: no_indep
    type:
      - 'null'
      - boolean
    doc: Don't use independent probability score column
    inputBinding:
      position: 104
      prefix: --no_indep
  - id: orf_coords
    type:
      - 'null'
      - File
    doc: Filename to specify a list of orfs that should be scored separately
    inputBinding:
      position: 104
      prefix: --orf_coords
  - id: rbs_pwm
    type:
      - 'null'
      - File
    doc: Position weight matrix (PWM) filename to identify ribosome binding site
    inputBinding:
      position: 104
      prefix: --rbs_pwm
  - id: separate_genes
    type:
      - 'null'
      - boolean
    doc: Input sequence-file is a multifasta file of separate genes to be scored
      separately
    inputBinding:
      position: 104
      prefix: --separate_genes
  - id: start_codons
    type:
      - 'null'
      - string
    doc: Comma-separated list of codons as start codons
    inputBinding:
      position: 104
      prefix: --start_codons
  - id: start_probs
    type:
      - 'null'
      - string
    doc: Probability of different start codons
    inputBinding:
      position: 104
      prefix: --start_probs
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: Comma-separated list of codons as stop codons
    inputBinding:
      position: 104
      prefix: --stop_codons
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold score for calling as gene
    inputBinding:
      position: 104
      prefix: --threshold
  - id: trans_table
    type:
      - 'null'
      - int
    doc: Genbank translation table number for stop codons
    inputBinding:
      position: 104
      prefix: --trans_table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
stdout: reparation_blast_glimmer3.out
