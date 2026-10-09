cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - utils
  - split-genomes
label: kmcp_utils_split_genomes
doc: "Split genomes into chunks\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: circular
    type: ['null', boolean]
    doc: "Input sequences are circular. Note that it only applies to genomes with a single chromosome"
    inputBinding:
      position: 1
      prefix: "--circular"
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
  - id: frag_size
    type: ['null', int]
    doc: "Size of sequence fragments to be assigned to the reference genome chunks (default 100)"
    inputBinding:
      position: 1
      prefix: "--frag-size"
  - id: in_dir
    type: ['null', Directory]
    doc: "Directory containing FASTA files. Directory symlinks are followed"
    inputBinding:
      position: 1
      prefix: "--in-dir"
  - id: info_file
    type: ['null', string]
    doc: "An extra output file to show which chunk(s) are assigned to for each genome fragment"
    inputBinding:
      position: 1
      prefix: "--info-file"
  - id: kmer
    type: ['null', int]
    doc: "K-mer size (default 21)"
    inputBinding:
      position: 1
      prefix: "--kmer"
  - id: out_dir
    type: string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: "--out-dir"
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
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Plain or gzipped FASTA files (one single genome file is preferred)"
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
    doc: "Directory with the genome chunks"
    outputBinding:
      glob: $(inputs.out_dir)
  - id: info
    type: ['null', File]
    doc: "Chunk assignment file"
    outputBinding:
      glob: $(inputs.info_file)
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
stdout: kmcp_utils_split_genomes.out
