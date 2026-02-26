cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfastats
label: gfastats
doc: "Calculates statistics for FASTA, FASTQ, and GFA files.\n\nTool homepage: https://github.com/vgl-hub/gfastats"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (fasta, fastq, gfa [.gz]). Also as first positional 
      argument.
    inputBinding:
      position: 1
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated genome size for NG* statistics (optional).
    inputBinding:
      position: 2
  - id: header_coords
    type:
      - 'null'
      - string
    doc: Target specific sequence by header, optionally with coordinates 
      (optional).
    inputBinding:
      position: 3
  - id: agp_to_path
    type:
      - 'null'
      - File
    doc: Converts input agp to path and replaces existing paths.
    inputBinding:
      position: 104
      prefix: --agp-to-path
  - id: cmd
    type:
      - 'null'
      - boolean
    doc: Print $0 to stdout.
    inputBinding:
      position: 104
      prefix: --cmd
  - id: discover_paths
    type:
      - 'null'
      - boolean
    doc: Prototype to induce paths from input.
    inputBinding:
      position: 104
      prefix: --discover-paths
  - id: discover_terminal_overlaps
    type:
      - 'null'
      - int
    doc: 'Append perfect terminal overlaps of minimum length n (default: 1000).'
    default: 1000
    inputBinding:
      position: 104
      prefix: --discover-terminal-overlaps
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: Opposite of --include-bed. They can be combined (no coordinates).
    inputBinding:
      position: 104
      prefix: --exclude-bed
  - id: homopolymer_compress
    type:
      - 'null'
      - int
    doc: Compress all the homopolymers longer than n in the input.
    inputBinding:
      position: 104
      prefix: --homopolymer-compress
  - id: include_bed
    type:
      - 'null'
      - File
    doc: Generates output on a subset list of headers or coordinates in 0-based 
      bed format.
    inputBinding:
      position: 104
      prefix: --include-bed
  - id: input_sequence
    type:
      - 'null'
      - File
    doc: Input file (fasta, fastq, gfa [.gz]). Also as first positional 
      argument.
    inputBinding:
      position: 104
      prefix: --input-sequence
  - id: line_length
    type:
      - 'null'
      - int
    doc: Specifies line length in when output format is fasta. Default has no 
      line breaks.
    inputBinding:
      position: 104
      prefix: --line-length
  - id: locale
    type:
      - 'null'
      - string
    doc: Set a different locale, for instance to use , for thousand separators 
      use en_US.UTF-8.
    inputBinding:
      position: 104
      prefix: --locale
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: Do not output the sequence (eg. in gfa).
    inputBinding:
      position: 104
      prefix: --no-sequence
  - id: nstar_report
    type:
      - 'null'
      - boolean
    doc: Generates full N* and L* statistics.
    inputBinding:
      position: 104
      prefix: --nstar-report
  - id: out_bubbles
    type:
      - 'null'
      - boolean
    doc: Outputs a potential list of bubbles in the graph.
    inputBinding:
      position: 104
      prefix: --out-bubbles
  - id: out_coord
    type:
      - 'null'
      - string
    doc: Generates bed coordinates of given feature (agp|scaffolds|contigs|gaps 
      default:agp).
    default: agp
    inputBinding:
      position: 104
      prefix: --out-coord
  - id: out_format
    type:
      - 'null'
      - string
    doc: Outputs selected sequences. If more than the extension is provided the 
      output is written to the specified file (e.g. out.fasta.gz). Multiple file
      outputs can be given at once.
    inputBinding:
      position: 104
      prefix: --out-format
  - id: out_sequence
    type:
      - 'null'
      - boolean
    doc: Reports also the actual sequence (in combination with --seq-report).
    inputBinding:
      position: 104
      prefix: --out-sequence
  - id: out_size
    type:
      - 'null'
      - string
    doc: Generates size list of given feature (scaffolds|contigs|gaps 
      default:scaffolds).
    default: scaffolds
    inputBinding:
      position: 104
      prefix: --out-size
  - id: path_report
    type:
      - 'null'
      - boolean
    doc: Report statistics for each path/scaffold.
    inputBinding:
      position: 104
      prefix: --path-report
  - id: remove_terminal_gaps
    type:
      - 'null'
      - boolean
    doc: Removes leading/trailing Ns from scaffolds.
    inputBinding:
      position: 104
      prefix: --remove-terminal-gaps
  - id: segment_report
    type:
      - 'null'
      - boolean
    doc: Report statistics for each segment/contig.
    inputBinding:
      position: 104
      prefix: --segment-report
  - id: sort
    type:
      - 'null'
      - string
    doc: Sort sequences according to input. Ascending/descending used the 
      sequence/path header.
    inputBinding:
      position: 104
      prefix: --sort
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Report summary statistics (default).
    default: true
    inputBinding:
      position: 104
      prefix: --stats
  - id: swiss_army_knife
    type:
      - 'null'
      - File
    doc: Set of instructions provided as an ordered list.
    inputBinding:
      position: 104
      prefix: --swiss-army-knife
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: Output in tabular format.
    inputBinding:
      position: 104
      prefix: --tabular
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Numbers of threads (default: max).'
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfastats:1.3.11--h077b44d_0
stdout: gfastats.out
