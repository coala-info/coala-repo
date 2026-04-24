cwlVersion: v1.2
class: CommandLineTool
baseCommand: kast
label: kast
doc: "Perform Alignment-free k-tuple frequency comparisons from sequences. This can
  be in the form of two input files (e.g. a reference and a query) or a single file
  for pairwise comparisons to be made.\n\nTool homepage: https://github.com/DelphiWorlds/Kastri"
inputs:
  - id: calc_gc
    type:
      - 'null'
      - boolean
    doc: Calculate GC content of query/ref in search mode.
    inputBinding:
      position: 101
      prefix: --calc-gc
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug Messages.
    inputBinding:
      position: 101
      prefix: --debug
  - id: distance_type
    type:
      - 'null'
      - string
    doc: The method of calculating the distance between two sequences. For 
      descriptions of distance please refer to the wiki. One of d2, euclid, d2s,
      d2star, manhattan, chebyshev, dai, bc, ngd, all, canberra, 
      normalised_canberra, and cosine.
    inputBinding:
      position: 101
      prefix: --distance-type
  - id: filter_bp
    type:
      - 'null'
      - int
    doc: In search mode, only match those results where the query and ref 
      sequence lengths are within +/- bp of oneanother.
    inputBinding:
      position: 101
      prefix: --filter-bp
  - id: filter_percent
    type:
      - 'null'
      - float
    doc: In search mode, only match those results where the query and ref 
      sequence lengths are within +/- percentage of oneanother.
    inputBinding:
      position: 101
      prefix: --filter-percent
  - id: interleaved_file
    type:
      - 'null'
      - File
    doc: Path to the file containing your sequence data which is interleaved.
    inputBinding:
      position: 101
      prefix: --interleaved-file
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer Length.
    inputBinding:
      position: 101
      prefix: --klen
  - id: markov_order
    type:
      - 'null'
      - int
    doc: Markov Order
    inputBinding:
      position: 101
      prefix: --markov-order
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not print header when performing search mode.
    inputBinding:
      position: 101
      prefix: --no-header
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: Do not use reverse compliment.
    inputBinding:
      position: 101
      prefix: --no-reverse
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of Cores.
    inputBinding:
      position: 101
      prefix: --num-cores
  - id: num_hits
    type:
      - 'null'
      - int
    doc: Number of top hits to return when running a Ref/Query search. If you 
      want all the result, enter 0.
    inputBinding:
      position: 101
      prefix: --num-hits
  - id: output_format
    type:
      - 'null'
      - string
    doc: For Reference/query based usage you can select your output type. One of
      default, tabular, and blastlike.
    inputBinding:
      position: 101
      prefix: --output-format
  - id: pairwise_file
    type:
      - 'null'
      - File
    doc: Path to the file containing your sequence data which you will perform 
      pairwise comparison on.
    inputBinding:
      position: 101
      prefix: --pairwise-file
  - id: query_file
    type:
      - 'null'
      - File
    doc: Path to the file containing your query sequence data.
    inputBinding:
      position: 101
      prefix: --query-file
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Path to the file containing your reference sequence data.
    inputBinding:
      position: 101
      prefix: --reference-file
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: Score Cutoff for search mode.
    inputBinding:
      position: 101
      prefix: --score-cutoff
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: Define the type of sequence data to work with. One of dna, aa, and raa.
    inputBinding:
      position: 101
      prefix: --sequence-type
  - id: skip_mer
    type:
      - 'null'
      - type: array
        items: string
    doc: List of STRING's Specify binary masks where a zero indicates skipping 
      that base and one keeps it. e.g. 01110.
    inputBinding:
      position: 101
      prefix: --skip-mer
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kast:1.0.1_cv1
