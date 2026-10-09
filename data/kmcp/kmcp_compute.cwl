cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - compute
label: kmcp_compute
doc: "Generate k-mers (sketches) from FASTA/Q sequences\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: by_seq
    type: ['null', boolean]
    doc: "Compute k-mers (sketches) for each sequence, instead of the whole file"
    inputBinding:
      position: 1
      prefix: "--by-seq"
  - id: circular
    type: ['null', boolean]
    doc: "Input sequences are circular. Note that it only applies to genomes with a single chromosome"
    inputBinding:
      position: 1
      prefix: "--circular"
  - id: compress
    type: ['null', boolean]
    doc: "Output gzipped .unik files, it is slower and can save little space"
    inputBinding:
      position: 1
      prefix: "--compress"
  - id: file_regexp
    type: ['null', string]
    doc: "Regular expression for matching sequence files in -I/--in-dir, case ignored"
    inputBinding:
      position: 1
      prefix: "--file-regexp"
  - id: force
    type: ['null', boolean]
    doc: "Overwrite existed output directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: in_dir
    type: ['null', Directory]
    doc: "Directory containing FASTA/Q files. Directory symlinks are followed"
    inputBinding:
      position: 1
      prefix: "--in-dir"
  - id: kmer
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --kmer
    doc: "K-mer size(s). K needs to be <=64. Multiple values are supported, e.g. \"-k 21 -k 31\" (default 21)"
    inputBinding:
      position: 1
  - id: minimizer_w
    type: ['null', int]
    doc: "Minimizer window size"
    inputBinding:
      position: 1
      prefix: "--minimizer-w"
  - id: out_dir
    type: string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: "--out-dir"
  - id: ref_name_regexp
    type: ['null', string]
    doc: "Regular expression (must contains \"(\" and \")\") for extracting reference name from filename"
    inputBinding:
      position: 1
      prefix: "--ref-name-regexp"
  - id: scale
    type: ['null', int]
    doc: "Scale of the FracMinHash (Scaled MinHash), or down-sample factor for Syncmers and Minimizer (default 1)"
    inputBinding:
      position: 1
      prefix: "--scale"
  - id: seq_name_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --seq-name-filter
    doc: "List of regular expressions for filtering out sequences by header/name, case ignored"
    inputBinding:
      position: 1
  - id: split_min_ref
    type: ['null', int]
    doc: "Only splitting sequences >= X bp (default 1000)"
    inputBinding:
      position: 1
      prefix: "--split-min-ref"
  - id: split_number
    type: ['null', int]
    doc: "Chunk number for splitting sequences, incompatible with --split-size"
    inputBinding:
      position: 1
      prefix: "--split-number"
  - id: split_overlap
    type: ['null', int]
    doc: "Chunk overlap for splitting sequences (default k-1)"
    inputBinding:
      position: 1
      prefix: "--split-overlap"
  - id: split_size
    type: ['null', int]
    doc: "Chunk size for splitting sequences, incompatible with --split-number"
    inputBinding:
      position: 1
      prefix: "--split-size"
  - id: syncmer_s
    type: ['null', int]
    doc: "Length of the s-mer in Closed Syncmers"
    inputBinding:
      position: 1
      prefix: "--syncmer-s"
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Plain or gzipped FASTA/Q sequence files"
    inputBinding:
      position: 50
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: out_dir_out
    type: Directory
    doc: "Directory with the .unik files and the summary file _info.txt"
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_compute.out
