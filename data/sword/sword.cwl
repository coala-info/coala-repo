cwlVersion: v1.2
class: CommandLineTool
baseCommand: sword
label: sword
doc: "SWORD is a protein database search tool that uses a heuristic Smith-Waterman algorithm for sensitive and fast sequence alignment.\n\nTool homepage: https://github.com/rvaser/sword"
inputs:
  - id: query_file
    type: File
    doc: Input FASTA database query file
    inputBinding:
      position: 1
      prefix: --query
  - id: target_file
    type: File
    doc: Input FASTA database target file
    inputBinding:
      position: 1
      prefix: --target
  - id: gap_open
    type: ['null', int]
    doc: Gap opening penalty, a positive integer (default 10)
    inputBinding:
      position: 1
      prefix: --gap-open
  - id: gap_extend
    type: ['null', int]
    doc: Gap extension penalty, a positive integer not above the gap opening penalty (default 1)
    inputBinding:
      position: 1
      prefix: --gap-extend
  - id: matrix
    type: ['null', string]
    doc: Similarity matrix (BLOSUM_45, BLOSUM_50, BLOSUM_62, BLOSUM_80, BLOSUM_90, PAM_30, PAM_70, PAM_250; default BLOSUM_62)
    inputBinding:
      position: 1
      prefix: --matrix
  - id: output_file_path
    type: ['null', string]
    doc: Output file for the alignment (default stdout)
    inputBinding:
      position: 1
      prefix: --out
  - id: outfmt
    type: ['null', string]
    doc: Output format, one of bm0 (blast m0), bm8 (blast m8 tabular), bm9 (blast m9 commented tabular; default bm9)
    inputBinding:
      position: 1
      prefix: --outfmt
  - id: evalue
    type: ['null', float]
    doc: E-value threshold; alignments with a higher E-value are filtered (default 10.0)
    inputBinding:
      position: 1
      prefix: --evalue
  - id: max_aligns
    type: ['null', int]
    doc: Maximum number of alignments to output (default 10)
    inputBinding:
      position: 1
      prefix: --max-aligns
  - id: algorithm
    type: ['null', string]
    doc: Alignment algorithm, one of SW (Smith-Waterman local), NW (Needleman-Wunsch global), HW (semiglobal), OV (overlap) (default SW)
    inputBinding:
      position: 1
      prefix: --algorithm
  - id: kmer_length
    type: ['null', int]
    doc: Length of k-mers used for the database search, 3, 4 or 5 (default 3)
    inputBinding:
      position: 1
      prefix: --kmer-length
  - id: max_candidates
    type: ['null', int]
    doc: Number of target sequences per query passed to the alignment part (default 30000)
    inputBinding:
      position: 1
      prefix: --max-candidates
  - id: threshold
    type: ['null', int]
    doc: Minimum score for two k-mers to trigger a hit; 0 checks only exact k-mers (default 13)
    inputBinding:
      position: 1
      prefix: --threshold
  - id: threads
    type: ['null', int]
    doc: Number of threads in the thread pool (default hardware concurrency / 2)
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: output_file
    type: ['null', File]
    doc: Alignment output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sword:1.0.4--h9948957_5
stdout: sword.stdout.txt
