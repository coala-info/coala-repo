cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmer3
label: tigr-glimmer_glimmer3
doc: "Read DNA sequences in <sequence-file> and predict genes\nin them using the Interpolated
  Context Model in <icm-file>.\nOutput details go to file <tag>.detail and predictions
  go to\nfile <tag>.predict"
inputs:
  - id: sequence_file
    type: File
    doc: DNA sequence file
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
    doc: Read entropy profiles from <filename>. Format is one header line, then 
      20 lines of 3 columns each. Columns are amino acid, positive entropy, 
      negative entropy. Rows must be in order by amino acid code letter
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
    doc: 'Use <p> as GC percentage of independent model. Note: <p> should be a percentage,
      e.g., -C 45.2'
    inputBinding:
      position: 104
      prefix: --gc_percent
  - id: gene_len
    type:
      - 'null'
      - int
    doc: Set minimum gene length to <n>
    inputBinding:
      position: 104
      prefix: --gene_len
  - id: ignore
    type:
      - 'null'
      - File
    doc: <filename> specifies regions of bases that are off limits, so that no 
      bases within that area will be examined
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
    doc: Assume linear rather than circular genome, i.e., no wraparound
    inputBinding:
      position: 104
      prefix: --linear
  - id: max_olap
    type:
      - 'null'
      - int
    doc: Set maximum overlap length to <n>. Overlaps this short or shorter are 
      ignored.
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
    doc: Use <filename> to specify a list of orfs that should be scored 
      separately, with no overlap rules
    inputBinding:
      position: 104
      prefix: --orf_coords
  - id: rbs_pwm
    type:
      - 'null'
      - File
    doc: Read a position weight matrix (PWM) from <filename> to identify the 
      ribosome binding site to help choose start sites
    inputBinding:
      position: 104
      prefix: --rbs_pwm
  - id: separate_genes
    type:
      - 'null'
      - boolean
    doc: <sequence-file> is a multifasta file of separate genes to be scored 
      separately, with no overlap rules
    inputBinding:
      position: 104
      prefix: --separate_genes
  - id: start_codons
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of codons as start codons. Sample format: -A atg,gtg.
      Use -P option to specify relative proportions of use. If -P not used, then proportions
      will be equal'
    inputBinding:
      position: 104
      prefix: --start_codons
  - id: start_probs
    type:
      - 'null'
      - string
    doc: 'Specify probability of different start codons (same number & order as in
      -A option). If no -A option, then 3 values for atg, gtg and ttg in that order.
      Sample format: -P 0.6,0.35,0.05. If -A is specified without -P, then starts
      are equally likely.'
    inputBinding:
      position: 104
      prefix: --start_probs
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: 'Use comma-separated list of codons as stop codons. Sample format: -Z tag,tga,taa'
    inputBinding:
      position: 104
      prefix: --stop_codons
  - id: threshold
    type:
      - 'null'
      - float
    doc: Set threshold score for calling as gene to n. If the in-frame score >= 
      <n>, then the region is given a number and considered a potential gene.
    inputBinding:
      position: 104
      prefix: --threshold
  - id: trans_table
    type:
      - 'null'
      - int
    doc: Use Genbank translation table number <n> for stop codons
    inputBinding:
      position: 104
      prefix: --trans_table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_glimmer3.out
