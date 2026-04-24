cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal align
label: reveal_align
doc: "Construct a population graph from input genomes or other graphs.\n\nTool homepage:
  https://github.com/hakimel/reveal.js"
inputs:
  - id: inputfiles
    type:
      type: array
      items: File
    doc: Fasta or gfa files specifying either assembly/alignment graphs (.gfa) 
      or sequences (.fasta). When only one gfa file is supplied, variants are 
      called within the graph file.
    inputBinding:
      position: 1
  - id: cache
    type:
      - 'null'
      - boolean
    doc: When specified, it caches the suffix and lcp array to disk after 
      construction.
    inputBinding:
      position: 102
      prefix: --cache
  - id: gml_max_nodes
    type:
      - 'null'
      - int
    doc: Max number of nodes per graph in gml output.
    inputBinding:
      position: 102
      prefix: --gml-max
  - id: interactive_mumplot
    type:
      - 'null'
      - boolean
    doc: Show an interactive visualisation of the mumplot (depends on 
      matplotlib).
    inputBinding:
      position: 102
      prefix: -i
  - id: lcp_array
    type:
      - 'null'
      - File
    doc: Specify a preconstructed lcp array to decouple lcp array construction.
    inputBinding:
      position: 102
      prefix: --lcp
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Only align nodes that have maximally this many samples (default None).
    inputBinding:
      position: 102
      prefix: -x
  - id: min_length
    type:
      - 'null'
      - int
    doc: Min length of an exact match
    inputBinding:
      position: 102
      prefix: -m
  - id: min_n
    type:
      - 'null'
      - int
    doc: Only align graph on exact matches that occur in at least this many 
      samples.
    inputBinding:
      position: 102
      prefix: -n
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Only index nodes that occur in this many samples or more (default 1).
    inputBinding:
      position: 102
      prefix: -g
  - id: min_score
    type:
      - 'null'
      - int
    doc: Min score of an exact match (default 0), exact maches are scored by 
      their length and penalized by the indel they create with respect to 
      previously accepted exact matches.
    inputBinding:
      position: 102
      prefix: -c
  - id: mumplot
    type:
      - 'null'
      - boolean
    doc: Save a mumplot for the actual aligned chain of anchors (depends on 
      matplotlib).
    inputBinding:
      position: 102
      prefix: --mumplot
  - id: no_metadata
    type:
      - 'null'
      - boolean
    doc: Produce a gfa graph without node annotations, to ensure it's parseable 
      by other programs.
    inputBinding:
      position: 102
      prefix: --nometa
  - id: output
    type:
      - 'null'
      - string
    doc: Prefix of the variant and alignment graph files to produce, default is 
      "sequence1_sequence2"
    inputBinding:
      position: 102
      prefix: --output
  - id: output_paths
    type:
      - 'null'
      - boolean
    doc: Output paths in GFA.
    inputBinding:
      position: 102
      prefix: --paths
  - id: produce_gml
    type:
      - 'null'
      - boolean
    doc: Produce a gml graph instead gfa.
    inputBinding:
      position: 102
      prefix: --gml
  - id: reference
    type:
      - 'null'
      - string
    doc: Name of the sequence that should be used as a coordinate system or 
      reference.
    inputBinding:
      position: 102
      prefix: -r
  - id: suffix_array
    type:
      - 'null'
      - File
    doc: Specify a preconstructed suffix array to decouple suffix array 
      construction.
    inputBinding:
      position: 102
      prefix: --sa
  - id: target_sample
    type:
      - 'null'
      - string
    doc: Only align nodes in which this sample occurs.
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use for the alignment.
    inputBinding:
      position: 102
      prefix: --threads
  - id: wp_penalty
    type:
      - 'null'
      - float
    doc: Multiply penalty for a MUM by this number in scoring scheme.
    inputBinding:
      position: 102
      prefix: --wp
  - id: ws_score
    type:
      - 'null'
      - float
    doc: Multiply length of MUM by this number in scoring scheme.
    inputBinding:
      position: 102
      prefix: --ws
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_align.out
