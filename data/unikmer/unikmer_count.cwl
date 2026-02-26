cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - count
label: unikmer_count
doc: "Generate k-mers (sketch) from FASTA/Q sequences\n\nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: seq_files
    type:
      type: array
      items: File
    doc: Sequence files
    inputBinding:
      position: 1
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: only keep the canonical k-mers
    inputBinding:
      position: 102
      prefix: --canonical
  - id: circular
    type:
      - 'null'
      - boolean
    doc: circular genome
    inputBinding:
      position: 102
      prefix: --circular
  - id: compact
    type:
      - 'null'
      - boolean
    doc: write compact binary file with little loss of speed
    inputBinding:
      position: 102
      prefix: --compact
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level
    default: -1
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: data_dir
    type:
      - 'null'
      - string
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    default: '"/root/.unikmer"'
    inputBinding:
      position: 102
      prefix: --data-dir
  - id: hash
    type:
      - 'null'
      - boolean
    doc: save hash of k-mer, automatically on for k>32. This flag overides 
      global flag -c/--compact
    inputBinding:
      position: 102
      prefix: --hash
  - id: ignore_taxid
    type:
      - 'null'
      - boolean
    doc: ignore taxonomy information
    inputBinding:
      position: 102
      prefix: --ignore-taxid
  - id: infile_list
    type:
      - 'null'
      - string
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: kmer_len
    type: int
    doc: k-mer length
    inputBinding:
      position: 102
      prefix: --kmer-len
  - id: linear
    type:
      - 'null'
      - boolean
    doc: output k-mers in linear order, duplicate k-mers are not removed
    inputBinding:
      position: 102
      prefix: --linear
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
    default: 4294967295
    inputBinding:
      position: 102
      prefix: --max-taxid
  - id: minimizer_w
    type:
      - 'null'
      - int
    doc: minimizer window size
    inputBinding:
      position: 102
      prefix: --minimizer-w
  - id: more_verbose
    type:
      - 'null'
      - boolean
    doc: print extra verbose information
    inputBinding:
      position: 102
      prefix: --more-verbose
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: do not compress binary file (not recommended)
    inputBinding:
      position: 102
      prefix: --no-compress
  - id: nocheck_file
    type:
      - 'null'
      - boolean
    doc: do not check binary file, when using process substitution or named pipe
    inputBinding:
      position: 102
      prefix: --nocheck-file
  - id: out_prefix
    type: string
    doc: out file prefix ("-" for stdout)
    default: '"-"'
    inputBinding:
      position: 102
      prefix: --out-prefix
  - id: parse_taxid
    type:
      - 'null'
      - boolean
    doc: parse taxid from FASTA/Q header
    inputBinding:
      position: 102
      prefix: --parse-taxid
  - id: parse_taxid_regexp
    type:
      - 'null'
      - string
    doc: regular expression for passing taxid
    inputBinding:
      position: 102
      prefix: --parse-taxid-regexp
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: only count duplicate k-mers, for removing singleton in FASTQ
    inputBinding:
      position: 102
      prefix: --repeated
  - id: scale
    type:
      - 'null'
      - int
    doc: scale/down-sample factor
    default: 1
    inputBinding:
      position: 102
      prefix: --scale
  - id: seq_name_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: list of regular expressions for filtering out sequences by header/name,
      case ignored.
    inputBinding:
      position: 102
      prefix: --seq-name-filter
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort k-mers, this significantly reduce file size for k<=25. This flag 
      overides global flag -c/--compact
    inputBinding:
      position: 102
      prefix: --sort
  - id: syncmer_s
    type:
      - 'null'
      - int
    doc: closed syncmer length
    inputBinding:
      position: 102
      prefix: --syncmer-s
  - id: taxid
    type:
      - 'null'
      - string
    doc: global taxid
    inputBinding:
      position: 102
      prefix: --taxid
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 4
    inputBinding:
      position: 102
      prefix: -j
  - id: unique
    type:
      - 'null'
      - boolean
    doc: only count unique k-mers, which are not duplicate
    inputBinding:
      position: 102
      prefix: --unique
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
stdout: unikmer_count.out
