cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp compute
label: kmcp_compute
doc: "Generate k-mers (sketches) from FASTA/Q sequences\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input plain or gzipped FASTA/Q files
    inputBinding:
      position: 1
  - id: by_seq
    type:
      - 'null'
      - boolean
    doc: Compute k-mers (sketches) for each sequence, instead of the whole file.
    inputBinding:
      position: 102
      prefix: --by-seq
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Input sequences are circular. Note that it only applies to genomes with
      a single chromosome.
    inputBinding:
      position: 102
      prefix: --circular
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Output gzipped .unik files, it's slower and can save little space.
    inputBinding:
      position: 102
      prefix: --compress
  - id: file_regexp
    type:
      - 'null'
      - string
    doc: Regular expression for matching sequence files in -I/--in-dir, case 
      ignored.
    inputBinding:
      position: 102
      prefix: --file-regexp
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existed output directory.
    inputBinding:
      position: 102
      prefix: --force
  - id: in_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing FASTA/Q files. Directory symlinks are followed.
    inputBinding:
      position: 102
      prefix: --in-dir
  - id: infile_list
    type:
      - 'null'
      - File
    doc: File of input files list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: kmer
    type:
      - 'null'
      - type: array
        items: int
    doc: K-mer size(s). K needs to be <=64. Multiple values are supported, e.g.,
      "-k 21,31" or "-k 21 -k 31"
      - 21
    inputBinding:
      position: 102
      prefix: --kmer
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: minimizer_w
    type:
      - 'null'
      - int
    doc: Minimizer window size.
    inputBinding:
      position: 102
      prefix: --minimizer-w
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to file 
      with --log.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: ref_name_regexp
    type:
      - 'null'
      - string
    doc: Regular expression (must contains "(" and ")") for extracting reference
      name from filename.
    inputBinding:
      position: 102
      prefix: --ref-name-regexp
  - id: scale
    type:
      - 'null'
      - int
    doc: Scale of the FracMinHash (Scaled MinHash), or down-sample factor for 
      Syncmers and Minimizer.
    inputBinding:
      position: 102
      prefix: --scale
  - id: seq_name_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: List of regular expressions for filtering out sequences by header/name,
      case ignored.
    inputBinding:
      position: 102
      prefix: --seq-name-filter
  - id: split_min_ref
    type:
      - 'null'
      - int
    doc: Only splitting sequences >= X bp.
    inputBinding:
      position: 102
      prefix: --split-min-ref
  - id: split_number
    type:
      - 'null'
      - int
    doc: Chunk number for splitting sequences, incompatible with 
      -s/--split-size.
    inputBinding:
      position: 102
      prefix: --split-number
  - id: split_overlap
    type:
      - 'null'
      - int
    doc: Chunk overlap for splitting sequences. The default value will be set to
      k-1 unless you change it.
    inputBinding:
      position: 102
      prefix: --split-overlap
  - id: split_size
    type:
      - 'null'
      - int
    doc: Chunk size for splitting sequences, incompatible with 
      -n/--split-number.
    inputBinding:
      position: 102
      prefix: --split-size
  - id: syncmer_s
    type:
      - 'null'
      - int
    doc: Length of the s-mer in Closed Syncmers.
    inputBinding:
      position: 102
      prefix: --syncmer-s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs cores to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
