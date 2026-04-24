cwlVersion: v1.2
class: CommandLineTool
baseCommand: search
label: megagta_search
doc: "Search for genes in a de Bruijn graph.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: succinct_dbg
    type: File
    doc: Path to the succinct de Bruijn graph file.
    inputBinding:
      position: 1
  - id: gene_list
    type: File
    doc: Path to the gene list file.
    inputBinding:
      position: 2
  - id: starting_kmers_prefix
    type: string
    doc: Prefix for starting k-mers.
    inputBinding:
      position: 3
  - id: output_prefix
    type: string
    doc: Prefix for output files.
    inputBinding:
      position: 4
  - id: prune_len
    type: int
    doc: Length to prune.
    inputBinding:
      position: 5
  - id: low_cov_penalty
    type: float
    doc: Penalty for low coverage.
    inputBinding:
      position: 6
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 0, meaning auto-detect).'
    inputBinding:
      position: 7
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_search.out
