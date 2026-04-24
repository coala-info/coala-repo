cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer map
label: unikmer_map
doc: "Mapping k-mers back to the genome and extract successive regions/subsequences\n\
  \nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: allow_multiple_mapped_kmers
    type:
      - 'null'
      - boolean
    doc: allow multiple mapped k-mers
    inputBinding:
      position: 101
      prefix: --allow-multiple-mapped-kmers
  - id: circular
    type:
      - 'null'
      - boolean
    doc: circular genome. type "unikmer uniqs -h" for details
    inputBinding:
      position: 101
      prefix: --circular
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
      - Directory
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: genome
    type:
      - 'null'
      - type: array
        items: string
    doc: genomes in (gzipped) fasta file(s)
    inputBinding:
      position: 101
      prefix: --genome
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
      - File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: max_gap_num
    type:
      - 'null'
      - int
    doc: max number of gaps (consecutive unmapped k-mers)
    inputBinding:
      position: 101
      prefix: --max-gap-num
  - id: max_gap_size
    type:
      - 'null'
      - int
    doc: max gap size (the number of consecutive unmapped k-mers)
    inputBinding:
      position: 101
      prefix: --max-gap-size
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
    inputBinding:
      position: 101
      prefix: --max-taxid
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of subsequence
    inputBinding:
      position: 101
      prefix: --min-len
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
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: output fasta format instead of BED3
    inputBinding:
      position: 101
      prefix: --output-fasta
  - id: seq_name_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: list of regular expressions for filtering out sequences by header/name,
      case ignored
    inputBinding:
      position: 101
      prefix: --seq-name-filter
  - id: seqs_in_a_file_as_one_genome
    type:
      - 'null'
      - boolean
    doc: treat seqs in a genome file as one genome
    inputBinding:
      position: 101
      prefix: --seqs-in-a-file-as-one-genome
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
stdout: unikmer_map.out
