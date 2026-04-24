cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathracer
label: pathracer
doc: "PathRacer is a tool for aligning HMMs or sequences against assembly graphs.\n
  \nTool homepage: http://cab.spbu.ru/software/pathracer/"
inputs:
  - id: input_file
    type: File
    doc: input file (HMM or sequence)
    inputBinding:
      position: 1
  - id: load_from
    type: File
    doc: graph file to load from
    inputBinding:
      position: 2
  - id: aa
    type:
      - 'null'
      - boolean
    doc: match agains amino acid string(s)
    inputBinding:
      position: 103
      prefix: --aa
  - id: acc
    type:
      - 'null'
      - boolean
    doc: prefer accessions over names in output
    inputBinding:
      position: 103
      prefix: --acc
  - id: annotate_graph
    type:
      - 'null'
      - boolean
    doc: emit paths in GFA graph
    inputBinding:
      position: 103
      prefix: --annotate-graph
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: use profile's GA gathering cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_ga
  - id: cut_nc
    type:
      - 'null'
      - boolean
    doc: use profile's NC noise cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_nc
  - id: cut_tc
    type:
      - 'null'
      - boolean
    doc: use profile's TC trusted cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_tc
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable extensive debug output
    inputBinding:
      position: 103
      prefix: --debug
  - id: dom_e_threshold
    type:
      - 'null'
      - float
    doc: report domains <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: --domE
  - id: dom_t_threshold
    type:
      - 'null'
      - float
    doc: report domains >= this score cutoff in output
    inputBinding:
      position: 103
      prefix: --domT
  - id: draw
    type:
      - 'null'
      - boolean
    doc: draw pictures around the interesting edges
    inputBinding:
      position: 103
      prefix: --draw
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: report sequences <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: -E
  - id: edges
    type:
      - 'null'
      - type: array
        items: string
    doc: 'match around particular edges [default: all graph edges]'
    inputBinding:
      position: 103
      prefix: --edges
  - id: expand_coef
    type:
      - 'null'
      - float
    doc: overhang expansion coefficient for neighborhood search
    inputBinding:
      position: 103
      prefix: --expand-coef
  - id: expand_const
    type:
      - 'null'
      - float
    doc: const addition to overhang values for neighborhood search
    inputBinding:
      position: 103
      prefix: --expand-const
  - id: export_event_graph
    type:
      - 'null'
      - boolean
    doc: export event graph in cereal format
    inputBinding:
      position: 103
      prefix: --export-event-graph
  - id: f1_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 1 (MSV) threshold: promote hits w/ P <= F1'
    inputBinding:
      position: 103
      prefix: --F1
  - id: f2_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 2 (Vit) threshold: promote hits w/ P <= F2'
    inputBinding:
      position: 103
      prefix: --F2
  - id: f3_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 3 (Fwd) threshold: promote hits w/ P <= F3'
    inputBinding:
      position: 103
      prefix: --F3
  - id: global
    type:
      - 'null'
      - boolean
    doc: perform global-local (aka glocal) HMM matching [default]
    inputBinding:
      position: 103
      prefix: --global
  - id: hmm
    type:
      - 'null'
      - boolean
    doc: match against HMM(s) [default]
    inputBinding:
      position: 103
      prefix: --hmm
  - id: ignore_names
    type:
      - 'null'
      - boolean
    doc: ignore HMM/sequence names (in case of dups, etc)
    inputBinding:
      position: 103
      prefix: --ignore-names
  - id: inc_dom_e_threshold
    type:
      - 'null'
      - float
    doc: consider domains <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: -incdomE
  - id: inc_dom_t_threshold
    type:
      - 'null'
      - float
    doc: consider domains >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: -incdomT
  - id: inc_e_threshold
    type:
      - 'null'
      - float
    doc: consider sequences <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: -incE
  - id: inc_t_threshold
    type:
      - 'null'
      - float
    doc: consider sequences >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: -incT
  - id: indel_rate
    type:
      - 'null'
      - float
    doc: expected rate of nucleotides indels in graph edges. Used for AA pHMM alignment
      with frame shifts
    inputBinding:
      position: 103
      prefix: --indel-rate
  - id: known_sequences
    type:
      - 'null'
      - File
    doc: FASTA file with known sequnces that should be definitely found
    inputBinding:
      position: 103
      prefix: --known-sequences
  - id: length
    type:
      - 'null'
      - float
    doc: minimal length of resultant matched sequence; if <=1 then to be multiplied
      on the length of the pHMM
    inputBinding:
      position: 103
      prefix: --length
  - id: local
    type:
      - 'null'
      - boolean
    doc: perform local-local HMM matching
    inputBinding:
      position: 103
      prefix: --local
  - id: max
    type:
      - 'null'
      - boolean
    doc: Turn all heuristic filters off (less speed, more power)
    inputBinding:
      position: 103
      prefix: --max
  - id: max_insertion_length
    type:
      - 'null'
      - int
    doc: maximal allowed number of successive I-emissions
    inputBinding:
      position: 103
      prefix: --max-insertion-length
  - id: max_size
    type:
      - 'null'
      - string
    doc: maximal component size to consider
    inputBinding:
      position: 103
      prefix: --max-size
  - id: memory
    type:
      - 'null'
      - int
    doc: RAM limit for PathRacer in GB (terminates if exceeded)
    inputBinding:
      position: 103
      prefix: --memory
  - id: no_fast_forward
    type:
      - 'null'
      - boolean
    doc: disable fast forward in I-loops processing
    inputBinding:
      position: 103
      prefix: --no-fast-forward
  - id: no_top_score_filter
    type:
      - 'null'
      - boolean
    doc: disable top score Event Graph vertices filter
    inputBinding:
      position: 103
      prefix: --no-top-score-filter
  - id: noali
    type:
      - 'null'
      - boolean
    doc: don't output alignments, so output is smaller
    inputBinding:
      position: 103
      prefix: --noali
  - id: nt
    type:
      - 'null'
      - boolean
    doc: match against nucleotide string(s)
    inputBinding:
      position: 103
      prefix: --nt
  - id: parallel_components
    type:
      - 'null'
      - boolean
    doc: process connected components of neighborhood subgraph in parallel
    inputBinding:
      position: 103
      prefix: --parallel-components
  - id: queries
    type:
      - 'null'
      - type: array
        items: string
    doc: 'queries names to lookup [default: all queries from input query file]'
    inputBinding:
      position: 103
      prefix: --queries
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet, do not output anything to the console
    inputBinding:
      position: 103
      prefix: --quiet
  - id: rescore
    type:
      - 'null'
      - boolean
    doc: rescore paths via HMMer
    inputBinding:
      position: 103
      prefix: --rescore
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: report sequences >= this score threshold in output
    inputBinding:
      position: 103
      prefix: -T
  - id: seed_edges
    type:
      - 'null'
      - boolean
    doc: use graph edges as seeds
    inputBinding:
      position: 103
      prefix: --seed-edges
  - id: seed_edges_1_by_1
    type:
      - 'null'
      - boolean
    doc: use edges as seeds (1 by 1)
    inputBinding:
      position: 103
      prefix: --seed-edges-1-by-1
  - id: seed_edges_scaffolds
    type:
      - 'null'
      - boolean
    doc: use edges AND scaffolds paths as seeds [default]
    inputBinding:
      position: 103
      prefix: --seed-edges-scaffolds
  - id: seed_exhaustive
    type:
      - 'null'
      - boolean
    doc: exhaustive mode, use ALL edges
    inputBinding:
      position: 103
      prefix: --seed-exhaustive
  - id: seed_scaffolds
    type:
      - 'null'
      - boolean
    doc: use scaffolds paths as seeds
    inputBinding:
      position: 103
      prefix: --seed-scaffolds
  - id: seed_scaffolds_1_by_1
    type:
      - 'null'
      - boolean
    doc: use scaffolds paths as seeds (1 by 1)
    inputBinding:
      position: 103
      prefix: --seed-scaffolds-1-by-1
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of parallel threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: top
    type:
      - 'null'
      - int
    doc: extract top N paths
    inputBinding:
      position: 103
      prefix: --top
outputs:
  - id: output_directory
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathracer:3.16.0.dev--h95f258a_0
