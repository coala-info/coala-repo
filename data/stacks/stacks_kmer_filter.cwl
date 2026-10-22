cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer_filter
label: stacks_kmer_filter
doc: "Filter and normalize reads based on the frequency of their k-mers.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -f
    doc: "path to the input file if processing single-end sequences (repeat for several files)"
    inputBinding:
      position: 101
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "path to a directory of files (for single-end files only)"
    inputBinding:
      position: 101
      prefix: -p
  - id: pair_1
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: '-1'
    doc: "first file of each pair of files to be processed together"
    inputBinding:
      position: 101
  - id: pair_2
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: '-2'
    doc: "second file of each pair of files to be processed together"
    inputBinding:
      position: 101
  - id: input_type
    type:
      - 'null'
      - string
    doc: "input file type, either 'bustard' for the Illumina BUSTARD output files, 'fasta', 'fastq', 'gzfasta', or 'gzfastq' (default 'fastq')"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_type
    type:
      - 'null'
      - string
    doc: "output type, either 'fastq' or 'fasta' (default fastq)"
    inputBinding:
      position: 101
      prefix: -y
  - id: capture_discarded
    type:
      - 'null'
      - boolean
    doc: "capture discarded reads to a file"
    inputBinding:
      position: 101
      prefix: -D
  - id: rare
    type:
      - 'null'
      - boolean
    doc: "turn on filtering based on rare k-mers"
    inputBinding:
      position: 101
      prefix: --rare
  - id: abundant
    type:
      - 'null'
      - boolean
    doc: "turn on filtering based on abundant k-mers"
    inputBinding:
      position: 101
      prefix: --abundant
  - id: k_len
    type:
      - 'null'
      - int
    doc: "specify k-mer size (default 15)"
    inputBinding:
      position: 101
      prefix: --k-len
  - id: max_k_freq
    type:
      - 'null'
      - int
    doc: "specify the number of times a kmer must occur to be considered abundant (default 20,000)"
    inputBinding:
      position: 101
      prefix: --max-k-freq
  - id: min_lim
    type:
      - 'null'
      - int
    doc: "specify number of rare kmers occuring in a row required to discard a read (default 80% of the k-mer length)"
    inputBinding:
      position: 101
      prefix: --min-lim
  - id: max_lim
    type:
      - 'null'
      - int
    doc: "specify number of abundant kmers required to discard a read (default 80% of the k-mers in a read)"
    inputBinding:
      position: 101
      prefix: --max-lim
  - id: normalize
    type:
      - 'null'
      - int
    doc: "normalize read depth according to k-mer coverage (depth)"
    inputBinding:
      position: 101
      prefix: --normalize
  - id: write_k_freq
    type:
      - 'null'
      - boolean
    doc: "write kmers along with their frequency of occurrence and exit"
    inputBinding:
      position: 101
      prefix: --write-k-freq
  - id: k_dist
    type:
      - 'null'
      - boolean
    doc: "print k-mer frequency distribution and exit"
    inputBinding:
      position: 101
      prefix: --k-dist
  - id: read_k_freq
    type:
      - 'null'
      - File
    doc: "read a set of kmers along with their frequencies of occurrence instead of reading raw input files"
    inputBinding:
      position: 101
      prefix: --read-k-freq
  - id: output_dir_path
    type: string
    doc: "path to output the processed files"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the filtered reads
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.output_dir_path) { l.push({"entryname": inputs.output_dir_path, "entry": {"class": "Directory", "listing": []}, "writable": true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_kmer_filter.out
