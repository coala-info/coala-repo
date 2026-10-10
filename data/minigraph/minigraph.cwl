cwlVersion: v1.2
class: CommandLineTool
baseCommand: minigraph
label: minigraph
doc: "Proof-of-concept bidirected graph aligner and graph constructor\n\nTool homepage:
  https://github.com/lh3/minigraph"
inputs:
  - id: target_file
    type: File
    doc: Target graph (.gfa) or sequence file (.fa/.fasta)
    inputBinding:
      position: 1
  - id: query_files
    type:
      type: array
      items: File
    doc: Query sequence file(s) (.fa/.fasta)
    inputBinding:
      position: 2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28) [17]
    inputBinding:
      position: 103
      prefix: -k
  - id: window_size
    type:
      - 'null'
      - int
    doc: minimizer window size [11]
    inputBinding:
      position: 103
      prefix: -w
  - id: base_alignment
    type:
      - 'null'
      - boolean
    doc: perform base alignment; RECOMMENDED
    inputBinding:
      position: 103
      prefix: -c
  - id: frac_repetitive
    type:
      - 'null'
      - float
    doc: ignore top FLOAT fraction of repetitive minimizers [0.0002]
    inputBinding:
      position: 103
      prefix: -f
  - id: occurrence_threshold
    type:
      - 'null'
      - type: array
        items: int
    doc: choose the minimizer occurrence threshold within this interval [50,250]
    inputBinding:
      position: 103
      prefix: -U
      itemSeparator: ','
  - id: divergence
    type:
      - 'null'
      - float
    doc: expected sequence divergence [0.1]
    inputBinding:
      position: 103
      prefix: -j
  - id: max_gap
    type:
      - 'null'
      - string
    doc: stop chain enlongation if there are no minimizers in INT-bp [5000]
    inputBinding:
      position: 103
      prefix: -g
  - id: max_frag_len
    type:
      - 'null'
      - string
    doc: max fragment length (effective with -xsr or in the fragment mode) [0]
    inputBinding:
      position: 103
      prefix: -F
  - id: bandwidth
    type:
      - 'null'
      - type: array
        items: string
    doc: bandwidth for the two rounds of chaining [500,20000]
    inputBinding:
      position: 103
      prefix: -r
      itemSeparator: ','
  - id: min_minimizers
    type:
      - 'null'
      - type: array
        items: int
    doc: minimal number of minimizers on a graph/linear chain [5,5]
    inputBinding:
      position: 103
      prefix: -n
      itemSeparator: ','
  - id: min_chain_score
    type:
      - 'null'
      - type: array
        items: int
    doc: minimal graph/linear chaining score [50,40]
    inputBinding:
      position: 103
      prefix: -m
      itemSeparator: ','
  - id: min_secondary_ratio
    type:
      - 'null'
      - float
    doc: min secondary-to-primary score ratio [0.8]
    inputBinding:
      position: 103
      prefix: -p
  - id: max_secondary
    type:
      - 'null'
      - int
    doc: retain at most INT secondary mappings [5]
    inputBinding:
      position: 103
      prefix: -N
  - id: skip_self_diagonal
    type:
      - 'null'
      - boolean
    doc: skip self diagonal matches
    inputBinding:
      position: 103
      prefix: -D
  - id: ggen
    type:
      - 'null'
      - boolean
    doc: perform incremental graph generation
    inputBinding:
      position: 103
      prefix: --ggen
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: min mapping quality [5]
    inputBinding:
      position: 103
      prefix: -q
  - id: min_aln_len
    type:
      - 'null'
      - string
    doc: min alignment length [100000]
    inputBinding:
      position: 103
      prefix: -l
  - id: min_aln_len_depth
    type:
      - 'null'
      - string
    doc: min alignment length for depth calculation [20000]
    inputBinding:
      position: 103
      prefix: -d
  - id: min_variant_len
    type:
      - 'null'
      - int
    doc: min variant length [50]
    inputBinding:
      position: 103
      prefix: -L
  - id: call
    type:
      - 'null'
      - boolean
    doc: call the graph path in each bubble and output BED
    inputBinding:
      position: 103
      prefix: --call
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads [4]
    inputBinding:
      position: 103
      prefix: -t
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: output mappings to FILE [stdout]
    inputBinding:
      position: 103
      prefix: -o
  - id: minibatch_size
    type:
      - 'null'
      - string
    doc: minibatch size for mapping [500M]
    inputBinding:
      position: 103
      prefix: -K
  - id: linear_chains
    type:
      - 'null'
      - boolean
    doc: 'output linear chains in * sName sLen nMz div sStart sEnd qStart qEnd'
    inputBinding:
      position: 103
      prefix: -S
  - id: vertex_coordinate
    type:
      - 'null'
      - boolean
    doc: output in the vertex coordinate
    inputBinding:
      position: 103
      prefix: --vc
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Preset: lr (noisy long read mapping, the default), asm (asm-to-ref mapping), sr (short reads), ggs (incremental graph generation)'
    inputBinding:
      position: 103
      prefix: -x
outputs:
  - id: output
    type: stdout
    doc: Mappings or graph written to standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file written with -o
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minigraph:0.21--h577a1d6_3
stdout: minigraph.out
