cwlVersion: v1.2
class: CommandLineTool
baseCommand: sim4
label: sim4
doc: "sim4 aligns an expressed DNA sequence (EST, cDNA, mRNA) with a genomic
  sequence, allowing for introns. If the second file is a database of sequences, the
  sequence in the first file is aligned with each of them.\n\nTool homepage:
  http://globin.cse.psu.edu/html/docs/sim4.html"
inputs:
  - id: seq1
    type: File
    doc: "First sequence file (FASTA)"
    inputBinding:
      position: 1
  - id: seq2_db
    type: File
    doc: "Second sequence file or sequence database (FASTA)"
    inputBinding:
      position: 2
  - id: word_size
    type:
      - 'null'
      - int
    doc: "Word size for blast hits in the first stage (default 12)"
    inputBinding:
      position: 3
      prefix: W=
      separate: false
  - id: extension_termination
    type:
      - 'null'
      - int
    doc: "Value for terminating word extensions (default 12)"
    inputBinding:
      position: 3
      prefix: X=
      separate: false
  - id: msp_threshold_first_pass
    type:
      - 'null'
      - int
    doc: "MSP score threshold for the first pass (e.g. 16)"
    inputBinding:
      position: 3
      prefix: K=
      separate: false
  - id: msp_threshold_second_pass
    type:
      - 'null'
      - int
    doc: "MSP score threshold for the second pass (e.g. 12)"
    inputBinding:
      position: 3
      prefix: C=
      separate: false
  - id: search_direction
    type:
      - 'null'
      - int
    doc: "Direction of search: 0 '+' strand only, 1 '-' strand only, 2 both strands and report the best match (default 2)"
    inputBinding:
      position: 3
      prefix: R=
      separate: false
  - id: diagonal_bound
    type:
      - 'null'
      - int
    doc: "Bound for the range of diagonals within consecutive MSPs in an exon (default 10)"
    inputBinding:
      position: 3
      prefix: D=
      separate: false
  - id: msp_weight
    type:
      - 'null'
      - int
    doc: "Weight factor for MSP scores in relinking (default 500)"
    inputBinding:
      position: 3
      prefix: H=
      separate: false
  - id: output_format
    type:
      - 'null'
      - int
    doc: "Output format: exon endpoints only (0), alignment text (1), lav block format (2), both exon endpoints and alignment text (3, 4), exon and CDS coordinates in PipMaker exon file format (5)"
    inputBinding:
      position: 3
      prefix: A=
      separate: false
  - id: remove_polya
    type:
      - 'null'
      - int
    doc: "If not 0, remove poly-A tails (default 0)"
    inputBinding:
      position: 3
      prefix: P=
      separate: false
  - id: accuracy
    type:
      - 'null'
      - int
    doc: "Accuracy of sequences, non-zero for highly accurate (default 0)"
    inputBinding:
      position: 3
      prefix: N=
      separate: false
  - id: allow_ambiguity
    type:
      - 'null'
      - int
    doc: "If 0, disallow ambiguity codes other than N and X in the sequence data (default 1)"
    inputBinding:
      position: 3
      prefix: B=
      separate: false
  - id: coding_region
    type:
      - 'null'
      - string
    doc: "Coding region specification, n1..n2 (only with A=5)"
    inputBinding:
      position: 3
      prefix: S=
      separate: false
outputs:
  - id: alignments
    type: stdout
    doc: Alignments written to standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sim4:v0.0.20121010-5-deb_cv1
stdout: sim4.out
