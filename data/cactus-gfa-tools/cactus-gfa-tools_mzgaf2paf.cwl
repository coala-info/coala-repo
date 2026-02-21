cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mzgaf2paf
label: cactus-gfa-tools_mzgaf2paf
doc: "Convert minigraph --write-mz output(s) to PAF\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools"
inputs:
  - id: gaf
    type: File
    doc: Input GAF file
    inputBinding:
      position: 1
  - id: extra_gafs
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional input GAF files
    inputBinding:
      position: 2
  - id: min_block_length
    type:
      - 'null'
      - int
    doc: Ignore records with block length (GAF col 11) (only applies if query length
      > N) < N
    default: 0
    inputBinding:
      position: 103
      prefix: --min-block-length
  - id: min_gap
    type:
      - 'null'
      - int
    doc: Filter so that reported minimizer matches have >=N bases between them
    default: 0
    inputBinding:
      position: 103
      prefix: --min-gap
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Ignore records with MAPQ (GAF col 12) < N
    default: 0
    inputBinding:
      position: 103
      prefix: --min-mapq
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: Only write matches (formed by overlapping/adjacent mz chains) with length
      < N
    inputBinding:
      position: 103
      prefix: --min-match-len
  - id: min_node_length
    type:
      - 'null'
      - int
    doc: Ignore minimizers on GAF nodes of length < N
    default: 0
    inputBinding:
      position: 103
      prefix: --min-node-length
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: If >= query regions with size >= N overlap, ignore the query region. If 1
      query region with size >= N overlaps any regions of size <= N, ignore the smaller
      ones only. (0 = disable)
    default: 0
    inputBinding:
      position: 103
      prefix: --min-overlap-length
  - id: node_based_universal
    type:
      - 'null'
      - boolean
    doc: Universal computed on entire node instead of mapped region
    inputBinding:
      position: 103
      prefix: --node-based-universal
  - id: strict_universal
    type:
      - 'null'
      - boolean
    doc: Count mapq and block length filters against universal (instead of ignoring)
    inputBinding:
      position: 103
      prefix: --strict-unversal
  - id: target_prefix
    type:
      - 'null'
      - string
    doc: Prepend all target (graph) contig names with this prefix
    inputBinding:
      position: 103
      prefix: --target-prefix
  - id: universal_mz
    type:
      - 'null'
      - float
    doc: Filter minimizers that appear in fewer than this fraction of alignments to
      target
    default: 0.0
    inputBinding:
      position: 103
      prefix: --universal-mz
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
stdout: cactus-gfa-tools_mzgaf2paf.out
