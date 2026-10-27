cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - woltka
  - classify
label: woltka_classify
doc: "Main classification workflow: Alignments => profile(s).\n\nTool homepage: https://github.com/qiyunzhu/woltka"
inputs:
  - id: input_path
    type:
      - File
      - Directory
    doc: Path to input alignment file or directory of alignment files. Enter "-" for stdin.
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: Path to output profile file or directory of profile files.
    inputBinding:
      position: 101
      prefix: --output
  - id: format
    type:
      - 'null'
      - type: enum
        name: format_enum
        symbols: [sam, b6o, paf, map]
    doc: 'Format of read alignments: "sam": SAM format, "b6o": BLAST tabular format, "paf": PAF format, "map": simple query-to-subject map. If not specified, program will automatically infer from file content.'
    inputBinding:
      position: 101
      prefix: --format
  - id: filext
    type:
      - 'null'
      - string
    doc: Input filename extension following sample ID.
    inputBinding:
      position: 101
      prefix: --filext
  - id: samples
    type:
      - 'null'
      - string
    doc: Sample IDs to include in the analysis. Can be a comma-separated string or path to a list file. Also defines the order of samples in the output.
    inputBinding:
      position: 101
      prefix: --samples
  - id: demux
    type:
      - 'null'
      - boolean
    doc: Demultiplex alignment by first underscore in query identifier.
    inputBinding:
      position: 101
      prefix: --demux
  - id: no_demux
    type:
      - 'null'
      - boolean
    doc: Do not demultiplex alignment by first underscore in query identifier.
    inputBinding:
      position: 101
      prefix: --no-demux
  - id: exclude
    type:
      - 'null'
      - string
    doc: Subject IDs to exclude while parsing alignments. Can be a comma-separated string or path to a list file. If an alignment is hit, the entire query (and its paired mate, if any) will be dropped.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: trim_sub
    type:
      - 'null'
      - string
    doc: 'Trim subject IDs at the last given delimiter. Default: "_", or enter a custom value.'
    inputBinding:
      position: 101
      prefix: --trim-sub
  - id: nodes
    type:
      - 'null'
      - File
    doc: Hierarchies defined by NCBI nodes.dmp or compatible formats.
    inputBinding:
      position: 101
      prefix: --nodes
  - id: newick
    type:
      - 'null'
      - File
    doc: Hierarchies defined by a tree in Newick format.
    inputBinding:
      position: 101
      prefix: --newick
  - id: lineage
    type:
      - 'null'
      - File
    doc: Lineage strings. Can accept Greengenes-style rank prefix.
    inputBinding:
      position: 101
      prefix: --lineage
  - id: columns
    type:
      - 'null'
      - File
    doc: Table of classification units per rank (column).
    inputBinding:
      position: 101
      prefix: --columns
  - id: map
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --map
    doc: Mapping of lower classification units to higher ones. Can be given several times.
    inputBinding:
      position: 101
  - id: map_as_rank
    type:
      - 'null'
      - boolean
    doc: Extract rank name from map filename.
    inputBinding:
      position: 101
      prefix: --map-as-rank
  - id: map_no_rank
    type:
      - 'null'
      - boolean
    doc: Do not extract rank name from map filename.
    inputBinding:
      position: 101
      prefix: --map-no-rank
  - id: names
    type:
      - 'null'
      - File
    doc: Names of classification units as defined by NCBI names.dmp or a simple map.
    inputBinding:
      position: 101
      prefix: --names
  - id: rank
    type:
      - 'null'
      - string
    doc: Classify sequences at this rank. Enter "none" to directly report subjects; enter "free" for free-rank classification. Can specify multiple comma-separated ranks.
    inputBinding:
      position: 101
      prefix: --rank
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: One sequence can only be assigned to one classification unit, or remain unassigned if there is ambiguity. Otherwise, all candidate units are reported and their counts are normalized.
    inputBinding:
      position: 101
      prefix: --uniq
  - id: major
    type:
      - 'null'
      - int
    doc: In given-rank classification, use majority rule at this percentage threshold (51-99) to determine assignment when there are multiple candidates.
    inputBinding:
      position: 101
      prefix: --major
  - id: above
    type:
      - 'null'
      - boolean
    doc: In given-rank classification, allow assigning a sequence to a higher rank if it cannot be assigned to the current rank.
    inputBinding:
      position: 101
      prefix: --above
  - id: subok
    type:
      - 'null'
      - boolean
    doc: In free-rank classification, allow assigning a sequence to its direct subject, if applicable, before going up in hierarchy.
    inputBinding:
      position: 101
      prefix: --subok
  - id: coords
    type:
      - 'null'
      - File
    doc: Reference gene coordinates on genomes.
    inputBinding:
      position: 101
      prefix: --coords
  - id: overlap
    type:
      - 'null'
      - int
    doc: Read/gene overlapping percentage threshold (1-100, default 80).
    inputBinding:
      position: 101
      prefix: --overlap
  - id: stratify
    type:
      - 'null'
      - Directory
    doc: Directory of read-to-feature maps for stratification.
    inputBinding:
      position: 101
      prefix: --stratify
  - id: sizes
    type:
      - 'null'
      - File
      - string
    doc: Divide counts by subject sizes. Can provide a mapping file, or type "." to calculate from gene coordinates.
    inputBinding:
      position: 101
      prefix: --sizes
  - id: frac
    type:
      - 'null'
      - boolean
    doc: Divide counts by total count of each sample (i.e., fractions).
    inputBinding:
      position: 101
      prefix: --frac
  - id: scale
    type:
      - 'null'
      - string
    doc: Scale counts by this factor. Accepts "k", "M" suffixes.
    inputBinding:
      position: 101
      prefix: --scale
  - id: digits
    type:
      - 'null'
      - int
    doc: Round counts to this number of digits after the decimal point (0-10).
    inputBinding:
      position: 101
      prefix: --digits
  - id: to_biom
    type:
      - 'null'
      - boolean
    doc: Output profile in BIOM format.
    inputBinding:
      position: 101
      prefix: --to-biom
  - id: to_tsv
    type:
      - 'null'
      - boolean
    doc: Output profile in TSV format.
    inputBinding:
      position: 101
      prefix: --to-tsv
  - id: unassigned
    type:
      - 'null'
      - boolean
    doc: Report unassigned sequences.
    inputBinding:
      position: 101
      prefix: --unassigned
  - id: name_as_id
    type:
      - 'null'
      - boolean
    doc: Replace feature IDs with names.
    inputBinding:
      position: 101
      prefix: --name-as-id
  - id: add_rank
    type:
      - 'null'
      - boolean
    doc: Append feature ranks to table.
    inputBinding:
      position: 101
      prefix: --add-rank
  - id: add_lineage
    type:
      - 'null'
      - boolean
    doc: Append lineage strings to table.
    inputBinding:
      position: 101
      prefix: --add-lineage
  - id: outmap
    type:
      - 'null'
      - string
    doc: Write read-to-feature maps to this directory.
    inputBinding:
      position: 101
      prefix: --outmap
  - id: zipmap
    type:
      - 'null'
      - type: enum
        name: zipmap_enum
        symbols: [none, gz, bz2, xz]
    doc: Compress read-to-feature maps using this algorithm.
    inputBinding:
      position: 101
      prefix: --zipmap
  - id: outcov
    type:
      - 'null'
      - string
    doc: Write subject coverage maps to this directory.
    inputBinding:
      position: 101
      prefix: --outcov
  - id: cov_fmt
    type:
      - 'null'
      - type: enum
        name: cov_fmt_enum
        symbols: [bed, gff, 0e, 1e, 0i, 1i]
    doc: Format of subject coverage coordinates. Default is BED-like (0-based, exclusive end).
    inputBinding:
      position: 101
      prefix: --cov-fmt
  - id: chunk
    type:
      - 'null'
      - int
    doc: Number of queries to read and parse in each chunk of alignment.
    inputBinding:
      position: 101
      prefix: --chunk
  - id: cache
    type:
      - 'null'
      - int
    doc: Number of recent results to cache for faster classification.
    inputBinding:
      position: 101
      prefix: --cache
  - id: no_exe
    type:
      - 'null'
      - boolean
    doc: Disable calling external programs for decompression.
    inputBinding:
      position: 101
      prefix: --no-exe
outputs:
  - id: output_profile
    type:
      - 'null'
      - File
      - Directory
    doc: Output profile file, or directory of profile files when several ranks are given.
    outputBinding:
      glob: $(inputs.output_path)
  - id: outmap_dir
    type:
      - 'null'
      - Directory
    doc: Read-to-feature maps written by --outmap.
    outputBinding:
      glob: $(inputs.outmap)
  - id: outcov_dir
    type:
      - 'null'
      - Directory
    doc: Subject coverage maps written by --outcov.
    outputBinding:
      glob: $(inputs.outcov)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
