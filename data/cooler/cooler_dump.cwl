cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler dump
label: cooler_dump
doc: "Dump a cooler's data to a text stream.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: string
    doc: Path to COOL file or cooler URI.
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - string
    doc: "Join additional columns from the bin table\n                           \
      \       against the pixels. Provide a comma\n                              \
      \    separated list of column names (no spaces).\n                         \
      \         The merged columns will be suffixed by '1'\n                     \
      \             and '2' accordingly."
    inputBinding:
      position: 102
      prefix: --annotate
  - id: balanced
    type:
      - 'null'
      - boolean
    doc: "Apply balancing weights to data. This will\n                           \
      \       print an extra column called `balanced`"
    inputBinding:
      position: 102
      prefix: --balanced
  - id: chunksize
    type:
      - 'null'
      - int
    doc: "Sets the number of pixel records loaded from\n                         \
      \         disk at one time. Can affect the performance\n                   \
      \               of joins on high resolution datasets."
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: columns
    type:
      - 'null'
      - string
    doc: "Restrict output to a subset of columns,\n                              \
      \    provided as a comma-separated list."
    inputBinding:
      position: 102
      prefix: --columns
  - id: fill_lower
    type:
      - 'null'
      - boolean
    doc: "For coolers using 'symmetric-upper' storage,\n                         \
      \         populate implicit areas of the genomic query\n                   \
      \               box by generating lower triangle pixels. If\n              \
      \                    not specified, only upper triangle pixels\n           \
      \                       are reported. This option has no effect on\n       \
      \                           coolers stored in 'square' mode."
    inputBinding:
      position: 102
      prefix: --fill-lower
  - id: float_format
    type:
      - 'null'
      - string
    doc: "Format string for floating point numbers\n                             \
      \     (e.g. '.12g', '03.2f')."
    inputBinding:
      position: 102
      prefix: --float-format
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Print the header of column names as the\n                              \
      \    first row."
    inputBinding:
      position: 102
      prefix: --header
  - id: join
    type:
      - 'null'
      - boolean
    doc: "Print the full chromosome bin coordinates\n                            \
      \      instead of bin IDs. This will replace the\n                         \
      \         `bin1_id` column with `chrom1`,\n                                \
      \  `start1`,\n                                  and `end1`,\n              \
      \                    and the `bin2_id` column with\n                       \
      \           `chrom2`,\n                                  `start2` and `end2`."
    inputBinding:
      position: 102
      prefix: --join
  - id: na_rep
    type:
      - 'null'
      - string
    doc: "Missing data representation. Default is\n                              \
      \    empty ''."
    inputBinding:
      position: 102
      prefix: --na-rep
  - id: no_balance
    type:
      - 'null'
      - boolean
    doc: "Apply balancing weights to data. This will\n                           \
      \       print an extra column called `balanced`"
    inputBinding:
      position: 102
      prefix: --no-balance
  - id: one_based_ids
    type:
      - 'null'
      - boolean
    doc: "Print bin IDs as one-based rather than zero-\n                         \
      \         based."
    inputBinding:
      position: 102
      prefix: --one-based-ids
  - id: one_based_starts
    type:
      - 'null'
      - boolean
    doc: "Print start coordinates as one-based rather\n                          \
      \        than zero-based."
    inputBinding:
      position: 102
      prefix: --one-based-starts
  - id: range
    type:
      - 'null'
      - string
    doc: "The coordinates of a genomic region shown\n                            \
      \      along the row dimension, in UCSC-style\n                            \
      \      notation. (Example:\n                                  chr1:10,000,000-11,000,000).
      If omitted, the\n                                  entire contact matrix is
      printed."
    inputBinding:
      position: 102
      prefix: --range
  - id: range2
    type:
      - 'null'
      - string
    doc: "The coordinates of a genomic region shown\n                            \
      \      along the column dimension. If omitted, the\n                       \
      \           column range is the same as the row range."
    inputBinding:
      position: 102
      prefix: --range2
  - id: table
    type:
      - 'null'
      - string
    doc: "Which table to dump. Choosing 'chroms' or\n                            \
      \      'bins' will cause all pixel-related options\n                       \
      \           to be ignored. Note that for coolers stored\n                  \
      \                in 'symmetric-upper' mode, 'pixels' only holds\n          \
      \                        the upper triangle values of the matrix."
    inputBinding:
      position: 102
      prefix: --table
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: "Output text file If .gz extension is\n                                 \
      \ detected, file is written using zlib.\n                                  Default
      behavior is to stream to stdout."
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
