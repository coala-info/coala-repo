cwlVersion: v1.2
class: CommandLineTool
baseCommand: folddisco query
label: folddisco_query
doc: "Search for patterns in PDB files using an index.\n\nTool homepage: https://github.com/steineggerlab/folddisco"
inputs:
  - id: angle_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: Angle threshold. Multiple values can be separated by comma
    inputBinding:
      position: 101
      prefix: --angle
  - id: ca_distance_threshold
    type:
      - 'null'
      - float
    doc: C-alpha distance threshold in matching residues
    inputBinding:
      position: 101
      prefix: --ca-distance
  - id: connected_node
    type:
      - 'null'
      - int
    doc: Filter out structures/matches with connected node count smaller than 
      given value
    inputBinding:
      position: 101
      prefix: --connected-node
  - id: connected_node_ratio
    type:
      - 'null'
      - float
    doc: Filter out structures/matches with connected node count smaller than 
      given ratio
    inputBinding:
      position: 101
      prefix: --connected-node-ratio
  - id: covered_node
    type:
      - 'null'
      - int
    doc: Filter out structures not covered by given number of nodes with hashes
    inputBinding:
      position: 101
      prefix: --covered-node
  - id: covered_node_ratio
    type:
      - 'null'
      - float
    doc: Filter out structures not covered by given ratio of nodes with hashes
    inputBinding:
      position: 101
      prefix: --covered-node-ratio
  - id: distance_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: Distance threshold in Angstroms. Multiple values can be separated by 
      comma
    inputBinding:
      position: 101
      prefix: --distance
  - id: freq_filter
    type:
      - 'null'
      - float
    doc: Skip queries with hash frequency higher than given ratio
    inputBinding:
      position: 101
      prefix: --freq-filter
  - id: index_file
    type: File
    doc: Path of index table to load
    inputBinding:
      position: 101
      prefix: --index
  - id: length_penalty
    type:
      - 'null'
      - float
    doc: Length penalty for searching. Zero means no penalty and higher value 
      gives more penalty to longer structures
    inputBinding:
      position: 101
      prefix: --length-penalty
  - id: max_node
    type:
      - 'null'
      - int
    doc: Filter out structures of maximum matching node size smaller than given 
      value
    inputBinding:
      position: 101
      prefix: --max-node
  - id: max_node_ratio
    type:
      - 'null'
      - float
    doc: Filter out structures of maximum matching node size smaller than given 
      ratio
    inputBinding:
      position: 101
      prefix: --max-node-ratio
  - id: num_residue
    type:
      - 'null'
      - int
    doc: Number of residues cutoff
    inputBinding:
      position: 101
      prefix: --num-residue
  - id: partial_fit
    type:
      - 'null'
      - boolean
    doc: Superposition will find the best aligning substructure using LMS (Least
      Median of Squares)
    inputBinding:
      position: 101
      prefix: --partial-fit
  - id: pdb_file
    type: File
    doc: Path of PDB file to query
    inputBinding:
      position: 101
      prefix: --pdb
  - id: per_match
    type:
      - 'null'
      - boolean
    doc: Print output per match. Not working with --skip-match
    inputBinding:
      position: 101
      prefix: --per-match
  - id: per_structure
    type:
      - 'null'
      - boolean
    doc: Print output per structure
    inputBinding:
      position: 101
      prefix: --per-structure
  - id: plddt_cutoff
    type:
      - 'null'
      - float
    doc: pLDDT cutoff
    inputBinding:
      position: 101
      prefix: --plddt
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print header in output
    inputBinding:
      position: 101
      prefix: --header
  - id: print_web
    type:
      - 'null'
      - boolean
    doc: Print output for web
    inputBinding:
      position: 101
      prefix: --web
  - id: query
    type: string
    doc: Query string that specifies residues or a text file containing query
    inputBinding:
      position: 101
      prefix: --query
  - id: sampling_count
    type:
      - 'null'
      - int
    doc: Number of sampled hashes to search
    inputBinding:
      position: 101
      prefix: --sampling-count
  - id: sampling_ratio
    type:
      - 'null'
      - float
    doc: Sampling ratio for hashes used in searching. For long queries, smaller 
      ratio is recommended
    inputBinding:
      position: 101
      prefix: --sampling-ratio
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: IDF score cutoff
    inputBinding:
      position: 101
      prefix: --score
  - id: serial_index
    type:
      - 'null'
      - boolean
    doc: Handle residue indices serially
    inputBinding:
      position: 101
      prefix: --serial-index
  - id: skip_ca_match
    type:
      - 'null'
      - boolean
    doc: Print matching residues before C-alpha distance check
    inputBinding:
      position: 101
      prefix: --skip-ca-match
  - id: skip_match
    type:
      - 'null'
      - boolean
    doc: Skip matching residues
    inputBinding:
      position: 101
      prefix: --skip-match
  - id: sort_by_rmsd
    type:
      - 'null'
      - boolean
    doc: Sort output by RMSD. Not working with --skip-match
    inputBinding:
      position: 101
      prefix: --sort-by-rmsd
  - id: sort_by_score
    type:
      - 'null'
      - boolean
    doc: Sort output by score
    inputBinding:
      position: 101
      prefix: --sort-by-score
  - id: superpose
    type:
      - 'null'
      - boolean
    doc: Print U, T, CA of matching residues
    inputBinding:
      position: 101
      prefix: --superpose
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: top_n
    type:
      - 'null'
      - int
    doc: Limit output to top N structures
    inputBinding:
      position: 101
      prefix: --top
  - id: total_match
    type:
      - 'null'
      - int
    doc: Filter out structures with less than total match count
    inputBinding:
      position: 101
      prefix: --total-match
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
