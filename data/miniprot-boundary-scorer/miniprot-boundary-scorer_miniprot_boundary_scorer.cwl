cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniprot_boundary_scorer
label: miniprot-boundary-scorer_miniprot_boundary_scorer
doc: "The program parses the result of miniprot's \"--aln\" output. The input is read
  from stdin.\n\nTool homepage: https://github.com/tomasbruna/miniprot-boundary-scorer"
inputs:
  - id: input
    type: File
    doc: Input from stdin
    inputBinding:
      position: 1
  - id: boundary_frameshift_penalty
    type:
      - 'null'
      - int
    doc: Penalty for frameshifts around exon boundaries. After a frameshift is 
      detected, the rest of the exon boundary is scored (still using the 
      weighted score) by this penlalty, regardless of the actual matches in the 
      alignment.
    default: 4
    inputBinding:
      position: 102
      prefix: -f
  - id: exon_frameshift_stop_penalty
    type:
      - 'null'
      - int
    doc: Penalty for frameshifts and read-through stop codons in exons.
    default: 20
    inputBinding:
      position: 102
      prefix: -F
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: Penalty for gaps, both in exons and around intron boundaries.
    default: 4
    inputBinding:
      position: 102
      prefix: -g
  - id: kernel
    type:
      - 'null'
      - string
    doc: Specify type of weighting kernel used. Available options are 
      "triangular", "box", "parabolic" and "triweight". Triangular kernel is the
      default option.
    default: triangular
    inputBinding:
      position: 102
      prefix: -k
  - id: matrix_file
    type: File
    doc: Path to amino acid scoring matrix
    inputBinding:
      position: 102
      prefix: -s
  - id: min_exon_score
    type:
      - 'null'
      - float
    doc: Minimum exon score. Exons with lower scores (as well as introns 
      bordering such low-scoring exons and starts/stops inside them are not 
      printed). Initial exons are treated separately. See the options -x and -i 
      for details.
    inputBinding:
      position: 102
      prefix: -e
  - id: min_initial_exon_score
    type:
      - 'null'
      - float
    doc: Minimum initial exon score. Initial exons with lower scores (as well as
      introns bordering such low-scoring exons and starts inside them) are not 
      printed. Initial exons with scores between (-e and -x) must also define an
      initial intron which passes the -i filter.
    inputBinding:
      position: 102
      prefix: -x
  - id: min_initial_intron_score
    type:
      - 'null'
      - float
    doc: Minimum initial intron score. Initial introns bordering initial exons 
      with scores < -e that have lower intron scores (as well as initial exons 
      bordering such low-scoring introns and starts in those exons) are not 
      printed.
    inputBinding:
      position: 102
      prefix: -i
  - id: window_width
    type:
      - 'null'
      - int
    doc: Width of a scoring window around introns.
    default: 10
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_file
    type: File
    doc: Where to save output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniprot-boundary-scorer:1.0.1--h9948957_0
