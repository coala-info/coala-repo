cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - rfilter
label: unikmer_rfilter
doc: |-
  Filter k-mers by taxonomic rank

  Tool homepage: https://github.com/shenwei356/unikmer
inputs:
  - id: black_list
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --black-list
    doc: "black list of ranks to discard, e.g., '\"no rank\", \"clade\"'"
    inputBinding:
      position: 10
  - id: discard_noranks
    type: ['null', boolean]
    doc: "discard ranks without order, type \"unikmer filter --help\" for details"
    inputBinding:
      position: 10
      prefix: --discard-noranks
  - id: discard_root
    type: ['null', boolean]
    doc: "discard root taxid, defined by --root-taxid"
    inputBinding:
      position: 10
      prefix: --discard-root
  - id: equal_to
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --equal-to
    doc: "output taxIDs with rank equal to some ranks, multiple values can be separated with comma \",\" (e.g., -E \"genus,species\"), or give multiple times (e.g., -E genus -E species)"
    inputBinding:
      position: 10
  - id: higher_than
    type: ['null', string]
    doc: "output ranks higher than a rank, exclusive with --lower-than"
    inputBinding:
      position: 10
      prefix: --higher-than
  - id: list_order
    type: ['null', boolean]
    doc: "list defined ranks in order"
    inputBinding:
      position: 10
      prefix: --list-order
  - id: list_ranks
    type: ['null', boolean]
    doc: "list ordered ranks in taxonomy database"
    inputBinding:
      position: 10
      prefix: --list-ranks
  - id: lower_than
    type: ['null', string]
    doc: "output ranks lower than a rank, exclusive with --higher-than"
    inputBinding:
      position: 10
      prefix: --lower-than
  - id: rank_file
    type: ['null', File]
    doc: "user-defined ordered taxonomic ranks, type \"unikmer rfilter --help\" for details"
    inputBinding:
      position: 10
      prefix: --rank-file
  - id: root_taxid
    type: ['null', long]
    doc: "root taxid"
    inputBinding:
      position: 10
      prefix: --root-taxid
  - id: save_predictable_norank
    type: ['null', boolean]
    doc: "do not discard some special ranks without order when using -L, where rank of the closest higher node is still lower than rank cutoff"
    inputBinding:
      position: 10
      prefix: --save-predictable-norank
  - id: compact
    type: ['null', boolean]
    doc: "write compact binary file with little loss of speed"
    inputBinding:
      position: 10
      prefix: --compact
  - id: compression_level
    type: ['null', int]
    doc: "compression level"
    inputBinding:
      position: 10
      prefix: --compression-level
  - id: data_dir
    type: ['null', Directory]
    doc: "directory containing NCBI Taxonomy files, including nodes.dmp, names.dmp, merged.dmp and delnodes.dmp"
    inputBinding:
      position: 10
      prefix: --data-dir
  - id: ignore_taxid
    type: ['null', boolean]
    doc: "ignore taxonomy information"
    inputBinding:
      position: 10
      prefix: --ignore-taxid
  - id: infile_list
    type: ['null', File]
    doc: "file of input files list (one file per line), if given, they are appended to files from cli arguments (names inside must match the staged files; give them also in listed_files)"
    inputBinding:
      position: 10
      prefix: --infile-list
  - id: max_taxid
    type: ['null', long]
    doc: "for smaller TaxIds, we can use less space to store TaxIds. default value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds"
    inputBinding:
      position: 10
      prefix: --max-taxid
  - id: no_compress
    type: ['null', boolean]
    doc: "do not compress binary file (not recommended)"
    inputBinding:
      position: 10
      prefix: --no-compress
  - id: nocheck_file
    type: ['null', boolean]
    doc: "do not check binary file, when using process substitution or named pipe"
    inputBinding:
      position: 10
      prefix: --nocheck-file
  - id: threads
    type: ['null', int]
    doc: "number of CPUs to use"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbose
    type: ['null', boolean]
    doc: "print verbose information"
    inputBinding:
      position: 10
      prefix: --verbose
  - id: unik_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input k-mer binary (.unik) files. Required unless --infile-list is given."
    inputBinding:
      position: 200
  - id: out_prefix
    type: string
    doc: "Output file prefix (the wrapper requires a name; '-' for stdout is not supported)"
    inputBinding:
      position: 10
      prefix: --out-prefix
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the --infile-list file (staged into the working directory so the names resolve)."
outputs:
  - id: out_unik
    type: File
    doc: Output k-mer binary file (<out-prefix>.unik)
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
