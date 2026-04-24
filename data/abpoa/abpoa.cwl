cwlVersion: v1.2
class: CommandLineTool
baseCommand: abpoa
label: abpoa
doc: "adaptive banded Partial Order Alignment\n\nTool homepage: https://github.com/yangao07/abPOA"
inputs:
  - id: input_file
    type: File
    doc: Input sequences in FASTA/FASTQ format (or a list of files if -l is used)
    inputBinding:
      position: 1
  - id: aln_mode
    type:
      - 'null'
      - int
    doc: 'alignment mode: 0: global, 1: local, 2: extension'
    inputBinding:
      position: 102
      prefix: --aln-mode
  - id: amb_strand
    type:
      - 'null'
      - boolean
    doc: 'ambiguous strand mode: try the reverse complement if the current alignment
      score is too low'
    inputBinding:
      position: 102
      prefix: --amb-strand
  - id: amino_acid
    type:
      - 'null'
      - boolean
    doc: input sequences are amino acid (default is nucleotide)
    inputBinding:
      position: 102
      prefix: --amino-acid
  - id: cons_algrm
    type:
      - 'null'
      - int
    doc: 'consensus algorithm (0: heaviest bundling path, 1: most frequent bases)'
    inputBinding:
      position: 102
      prefix: --cons-algrm
  - id: extra_b
    type:
      - 'null'
      - int
    doc: first adaptive banding parameter; set < 0 to disable adaptive banded DP
    inputBinding:
      position: 102
      prefix: --extra-b
  - id: extra_f
    type:
      - 'null'
      - float
    doc: second adaptive banding parameter
    inputBinding:
      position: 102
      prefix: --extra-f
  - id: gap_at_end
    type:
      - 'null'
      - boolean
    doc: always put indel at the end of the alignment if possible
    inputBinding:
      position: 102
      prefix: --gap-at-end
  - id: gap_ext
    type:
      - 'null'
      - string
    doc: gap extension penalty (E1,E2)
    inputBinding:
      position: 102
      prefix: --gap-ext
  - id: gap_on_right
    type:
      - 'null'
      - boolean
    doc: put indel on the right-most side of the alignment, default is left
    inputBinding:
      position: 102
      prefix: --gap-on-right
  - id: gap_open
    type:
      - 'null'
      - string
    doc: gap opening penalty (O1,O2)
    inputBinding:
      position: 102
      prefix: --gap-open
  - id: in_list
    type:
      - 'null'
      - boolean
    doc: input file is a list of sequence file names
    inputBinding:
      position: 102
      prefix: --in-list
  - id: inc_path_score
    type:
      - 'null'
      - boolean
    doc: include log-scaled path score for graph alignment
    inputBinding:
      position: 102
      prefix: --inc-path-score
  - id: incrmnt
    type:
      - 'null'
      - File
    doc: incrementally align sequences to an existing graph/MSA
    inputBinding:
      position: 102
      prefix: --incrmnt
  - id: k_mer
    type:
      - 'null'
      - int
    doc: minimizer k-mer size
    inputBinding:
      position: 102
      prefix: --k-mer
  - id: match
    type:
      - 'null'
      - int
    doc: match score
    inputBinding:
      position: 102
      prefix: --match
  - id: matrix
    type:
      - 'null'
      - File
    doc: scoring matrix file, '-M' and '-X' are not used when '-t' is used
    inputBinding:
      position: 102
      prefix: --matrix
  - id: maxnum_cons
    type:
      - 'null'
      - int
    doc: max. number of consensus sequence to generate
    inputBinding:
      position: 102
      prefix: --maxnum-cons
  - id: min_freq
    type:
      - 'null'
      - float
    doc: min. frequency of each cluster
    inputBinding:
      position: 102
      prefix: --min-freq
  - id: min_poa_win
    type:
      - 'null'
      - int
    doc: min. size of window to perform POA
    inputBinding:
      position: 102
      prefix: --min-poa-win
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch penalty
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: progressive
    type:
      - 'null'
      - boolean
    doc: build guide tree and perform progressive partial order alignment
    inputBinding:
      position: 102
      prefix: --progressive
  - id: result
    type:
      - 'null'
      - int
    doc: 'output result mode (0: consensus FASTA, 1: MSA PIR, 2: both, 3: graph GFA,
      4: graph+consensus GFA, 5: consensus FASTQ)'
    inputBinding:
      position: 102
      prefix: --result
  - id: seeding
    type:
      - 'null'
      - boolean
    doc: enable minimizer-based seeding and anchoring
    inputBinding:
      position: 102
      prefix: --seeding
  - id: sort_by_len
    type:
      - 'null'
      - boolean
    doc: sort input sequences by length in descending order
    inputBinding:
      position: 102
      prefix: --sort-by-len
  - id: use_qual_weight
    type:
      - 'null'
      - boolean
    doc: take base quality score from FASTQ input file as graph edge weight for consensus
      calling
    inputBinding:
      position: 102
      prefix: --use-qual-weight
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbose level (0-2)
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: minimizer window size
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output to FILE
    outputBinding:
      glob: $(inputs.output)
  - id: out_pog
    type:
      - 'null'
      - File
    doc: dump final alignment graph to FILE (.pdf/.png)
    outputBinding:
      glob: $(inputs.out_pog)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abpoa:1.5.5--h577a1d6_0
