cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer dump
label: unikmer_dump
doc: "Convert plain k-mer text to binary format\n\nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: save the canonical k-mers
    inputBinding:
      position: 101
      prefix: --canonical
  - id: canonical_only
    type:
      - 'null'
      - boolean
    doc: only save the canonical k-mers. This flag overides -K/--canonical
    inputBinding:
      position: 101
      prefix: --canonical-only
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
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: hash
    type:
      - 'null'
      - boolean
    doc: save hash of k-mer, automatically on for k>32. This flag overides 
      global flag -c/--compact
    inputBinding:
      position: 101
      prefix: --hash
  - id: hashed
    type:
      - 'null'
      - boolean
    doc: giving hash values of k-mers, This flag overides global flag 
      -c/--compact
    inputBinding:
      position: 101
      prefix: --hashed
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
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: k-mer length
    inputBinding:
      position: 101
      prefix: --kmer-len
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
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
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: input k-mers are sorted
    inputBinding:
      position: 101
      prefix: --sorted
  - id: taxid
    type:
      - 'null'
      - string
    doc: global taxid
    inputBinding:
      position: 101
      prefix: --taxid
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: unique
    type:
      - 'null'
      - boolean
    doc: remove duplicate k-mers
    inputBinding:
      position: 101
      prefix: --unique
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
stdout: unikmer_dump.out
