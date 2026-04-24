cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - rfilter
label: unikmer_rfilter
doc: "Filter k-mers by taxonomic rank\n\nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: black_list
    type:
      - 'null'
      - type: array
        items: string
    doc: black list of ranks to discard, e.g., '"no rank", "clade"'
    inputBinding:
      position: 101
      prefix: --black-list
  - id: compact
    type:
      - 'null'
      - boolean
    doc: write compact binary file with little loss of speed
    inputBinding:
      position: 101
      prefix: --compact
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: data_dir
    type:
      - 'null'
      - string
    doc: "directory containing NCBI Taxonomy files, including nodes.dmp,\n       \
      \                         names.dmp, merged.dmp and delnodes.dmp"
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: discard_noranks
    type:
      - 'null'
      - boolean
    doc: discard ranks without order, type "unikmer filter --help" for details
    inputBinding:
      position: 101
      prefix: --discard-noranks
  - id: discard_root
    type:
      - 'null'
      - boolean
    doc: discard root taxid, defined by --root-taxid
    inputBinding:
      position: 101
      prefix: --discard-root
  - id: equal_to
    type:
      - 'null'
      - type: array
        items: string
    doc: "output taxIDs with rank equal to some ranks, multiple values can be\n  \
      \                                separated with comma \",\" (e.g., -E \"genus,species\"\
      ), or give multiple\n                                  times (e.g., -E genus
      -E species)"
    inputBinding:
      position: 101
      prefix: --equal-to
  - id: higher_than
    type:
      - 'null'
      - string
    doc: output ranks higher than a rank, exclusive with --lower-than
    inputBinding:
      position: 101
      prefix: --higher-than
  - id: ignore_taxid
    type:
      - 'null'
      - boolean
    doc: ignore taxonomy information
    inputBinding:
      position: 101
      prefix: --ignore-taxid
  - id: infile_list
    type:
      - 'null'
      - string
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                           appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: list_order
    type:
      - 'null'
      - boolean
    doc: list defined ranks in order
    inputBinding:
      position: 101
      prefix: --list-order
  - id: list_ranks
    type:
      - 'null'
      - boolean
    doc: list ordered ranks in taxonomy database
    inputBinding:
      position: 101
      prefix: --list-ranks
  - id: lower_than
    type:
      - 'null'
      - string
    doc: output ranks lower than a rank, exclusive with --higher-than
    inputBinding:
      position: 101
      prefix: --lower-than
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: "for smaller TaxIds, we can use less space to store TaxIds. default value\n\
      \                                is 1<<32-1, that's enough for NCBI Taxonomy
      TaxIds"
    inputBinding:
      position: 101
      prefix: --max-taxid
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: do not compress binary file (not recommended)
    inputBinding:
      position: 101
      prefix: --no-compress
  - id: nocheck_file
    type:
      - 'null'
      - boolean
    doc: do not check binary file, when using process substitution or named pipe
    inputBinding:
      position: 101
      prefix: --nocheck-file
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: out file prefix ("-" for stdout)
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: rank_file
    type:
      - 'null'
      - string
    doc: "user-defined ordered taxonomic ranks, type \"unikmer rfilter --help\"\n\
      \                                  for details"
    inputBinding:
      position: 101
      prefix: --rank-file
  - id: root_taxid
    type:
      - 'null'
      - string
    doc: root taxid
    inputBinding:
      position: 101
      prefix: --root-taxid
  - id: save_predictable_norank
    type:
      - 'null'
      - boolean
    doc: "do not discard some special ranks without order when using -L, where\n \
      \                                 rank of the closest higher node is still lower
      than rank cutoff"
    inputBinding:
      position: 101
      prefix: --save-predictable-norank
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
stdout: unikmer_rfilter.out
