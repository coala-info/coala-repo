cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexiplex-filter
label: flexiplex_flexiplex-filter
doc: "Finds the inflection point when demultiplexing using flexiplex and filters the
  barcode counts file (flexiplex_barcodes_counts.txt) by that point and an optional
  whitelist.\n\nTool homepage: https://github.com/DavidsonGroup/flexiplex/"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: Input file, typically called flexiplex_barcodes_counts.txt. Defaults to stdin
      if not given.
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output verbose and debugging information, and also display more potential
      inflection points.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: Output file, defaults to stdout if not given (ignored if --dry-run is active).
    inputBinding:
      position: 101
      prefix: --outfile
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Only output discovered inflection points, without performing the actual filtering.
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: no_inflection
    type:
      - 'null'
      - boolean
    doc: Do not search for an inflection point.
    inputBinding:
      position: 101
      prefix: --no-inflection
  - id: min_rank
    type:
      - 'null'
      - int
    doc: Lowest rank to search.
    inputBinding:
      position: 101
      prefix: --min-rank
  - id: max_rank
    type:
      - 'null'
      - int
    doc: Highest rank to search. Set to 0 to search to the end.
    inputBinding:
      position: 101
      prefix: --max-rank
  - id: graph
    type:
      - 'null'
      - boolean
    doc: Show a graph with the inflection point marked, requires matplotlib. Will
      also enable --dry-run.
    inputBinding:
      position: 101
      prefix: --graph
  - id: list_points
    type:
      - 'null'
      - int
    doc: Show multiple potential points. Will also enable --dry-run.
    inputBinding:
      position: 101
      prefix: --list-points
  - id: use_predetermined_rank
    type:
      - 'null'
      - int
    doc: Use predetermined inflection point. This will disable searching, but will
      still filter for all ranks <= r.
    inputBinding:
      position: 101
      prefix: --use-predetermined-rank
  - id: whitelist
    type:
      - 'null'
      - File
    doc: A whitelist file for known chemistry barcodes. If not given, no whitelist
      filtering is performed.
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Filtered barcode counts (when --outfile is given)
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: stdout
    type: stdout
    doc: Filtered barcode counts or inflection points written to standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
stdout: flexiplex_flexiplex-filter.out
