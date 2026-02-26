cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi paths
label: odgi_paths
doc: "Interrogate the embedded paths of a graph. Does not print anything to stdout
  by default!\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: coverage_levels
    type:
      - 'null'
      - string
    doc: List of coverage thresholds (number of paths that pass through the 
      node). Print to stdout a TAB-separated table with node ID, node length, 
      and class.
    inputBinding:
      position: 101
      prefix: --coverage-levels
  - id: delim
    type:
      - 'null'
      - string
    doc: The part of each path name before this delimiter CHAR is a group 
      identifier. For use with -H/--haplotypes, --non-reference-ranges or 
      --coverage-levels/fraction-levels. With -H/--haplotypes it prints an 
      additional, first column **group.name** to stdout.
    inputBinding:
      position: 101
      prefix: --delim
  - id: delim_pos
    type:
      - 'null'
      - int
    doc: Consider the N-th occurrence of the delimiter specified with **-D, 
      --delim** to obtain the group identifier. Specify 1 for the 1st occurrence
      (default).
    default: 1
    inputBinding:
      position: 101
      prefix: --delim-pos
  - id: drop_paths
    type:
      - 'null'
      - File
    doc: Drop paths listed (by line) in *FILE*.
    inputBinding:
      position: 101
      prefix: --drop-paths
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Print paths in FASTA format to stdout. One line for the FASTA header, 
      another line for the whole sequence.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fraction_levels
    type:
      - 'null'
      - string
    doc: List of fraction thresholds (fraction of paths that pass through the 
      node). Print to stdout a TAB-separated table with node ID , node length, 
      and class.
    inputBinding:
      position: 101
      prefix: --fraction-levels
  - id: haplotypes
    type:
      - 'null'
      - boolean
    doc: 'Print to stdout the paths in a path coverage haplotype matrix based on the
      graph’s sort order. The output is tab-delimited: *path.name*, *path.length*,
      *path.step.count*, *node.1*, *node.2*, *node.n*. Each path entry is printed
      in its own line.'
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: keep_paths
    type:
      - 'null'
      - File
    doc: Keep paths listed (by line) in *FILE*.
    inputBinding:
      position: 101
      prefix: --keep-paths
  - id: list_path_start_end
    type:
      - 'null'
      - boolean
    doc: If -L,--list-paths was specified, this additionally prints the start 
      and end positions of each path in additional, tab-delimited coloumns.
    inputBinding:
      position: 101
      prefix: --list-path-start-end
  - id: list_paths
    type:
      - 'null'
      - boolean
    doc: Print the paths in the graph to stdout. Each path is printed in its own
      line.
    inputBinding:
      position: 101
      prefix: --list-paths
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size (in bps) of nodes (with --non-reference-nodes or 
      --coverage-levels/fraction-levels) or ranges (with --non-reference-ranges 
      or --coverage-levels/fraction-levels together with --path-range-class). Or
      ranges (with --non-reference-ranges or --coverage-levels/fraction-levels 
      together with --path-range-class).
    inputBinding:
      position: 101
      prefix: --min-size
  - id: non_reference_nodes
    type:
      - 'null'
      - File
    doc: Print to stdout IDs of nodes that are not in the paths listed (by line)
      in *FILE*.
    inputBinding:
      position: 101
      prefix: --non-reference-nodes
  - id: non_reference_ranges
    type:
      - 'null'
      - File
    doc: Print to stdout (in BED format) path ranges that are not in the paths 
      listed (by line) in *FILE*.
    inputBinding:
      position: 101
      prefix: --non-reference-ranges
  - id: overlaps
    type:
      - 'null'
      - File
    doc: Read in the path grouping *FILE* to generate the overlap statistics 
      from. The file must be tab-delimited. The first column lists a grouping 
      and the second the path itself. Each line has one path entry. For each 
      group the pairwise overlap statistics for each pairing will be calculated 
      and printed to stdout.
    inputBinding:
      position: 101
      prefix: --overlaps
  - id: path_range_class
    type:
      - 'null'
      - boolean
    doc: Instead of node information, print to stdout a TAB-separated table with
      path range and class.
    inputBinding:
      position: 101
      prefix: --path-range-class
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: scale_by_node_len
    type:
      - 'null'
      - boolean
    doc: Scale the haplotype matrix cells by node length.
    inputBinding:
      position: 101
      prefix: --scale-by-node-len
  - id: show_step_ranges
    type:
      - 'null'
      - boolean
    doc: Show steps (that is, node IDs and strands) (with --non-reference-ranges
      or --coverage-levels/fraction-levels together with --path-range-class).
    inputBinding:
      position: 101
      prefix: --show-step-ranges
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write the dynamic succinct variation graph to this file (e.g. *.og*).
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
