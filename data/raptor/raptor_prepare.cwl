cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - raptor
  - prepare
label: raptor_prepare
doc: "Computes minimisers for the sequence files of the input list and writes one\
  \ minimiser file per input file to the output folder.\n\nTool homepage: https://github.com/seqan/raptor"
inputs:
  - id: input
    type: File
    doc: File containing file names. The file must contain at least one file path
      per line, with multiple paths being separated by a whitespace. Each line in
      the file corresponds to one bin. Valid extensions for the paths in the file
      are [minimiser] when using preprocessed input from raptor prepare, and [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
      possibly followed by [bz2,gz,bgzf]. The input file must exist and read permissions
      must be granted.
    inputBinding:
      position: 101
      prefix: --input
      valueFrom: $(self.basename)
  - id: bin_files
    type:
      type: array
      items: File
    doc: Sequence files (or minimiser files) named in the input file; staged in the
      working directory so the names resolve
  - id: output
    type: string
    doc: 'A valid path for the output directory. Will create a minimiser.list inside
      the output directory. This file contains a list of generated minimiser files,
      in the same order as the input. When you manually delete a .in_progress file,
      also delete the corresponding .header and .minimiser file! Created output files
      for each file: *.header: Contains the shape, window size, cutoff and minimiser
      count. *.minimiser: Contains binary minimiser values, one minimiser per line.
      *.in_progress: Temporary file to track process. Deleted after finishing computation.'
    inputBinding:
      position: 102
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use. Default: 1. Value must be a positive integer.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print time and memory usage.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'The k-mer size. Default: 20. Value must be in range [1,32].'
    inputBinding:
      position: 101
      prefix: --kmer
  - id: window
    type:
      - 'null'
      - int
    doc: 'The window size. Default: k-mer size. Value must be a positive integer.'
    inputBinding:
      position: 101
      prefix: --window
  - id: shape
    type:
      - 'null'
      - string
    doc: 'The shape to use for k-mers. Mutually exclusive with --kmer. Parsed from
      right to left. Default: 11111111111111111111 (a k-mer of size 20). Value must
      match the pattern ''[01]+''.'
    inputBinding:
      position: 101
      prefix: --shape
  - id: kmer_count_cutoff
    type:
      - 'null'
      - int
    doc: 'Only store k-mers with at least (>=) x occurrences. Mutually exclusive with
      --use-filesize-dependent-cutoff. Default: 1. Value must be in range [1,254].'
    inputBinding:
      position: 101
      prefix: --kmer-count-cutoff
  - id: use_filesize_dependent_cutoff
    type:
      - 'null'
      - boolean
    doc: ''
    inputBinding:
      position: 101
      prefix: --use-filesize-dependent-cutoff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (time and memory usage)
  - id: minimiser_dir
    type: Directory
    doc: Folder with the minimiser files
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input)
      - $(inputs.bin_files)
      - entryname: $(inputs.output)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor_prepare.out
