cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerInShort
label: kmerinshort_KmerInShort
doc: "KmerInShort counts k-mers (k < 15) from a FASTA/FASTQ file and writes the counts to a text file\n\nTool homepage: https://github.com/rizkg/KmerInShort"
inputs:
  - id: nb_cores
    type: ['null', int]
    doc: "Number of cores [default 0]"
    inputBinding:
      position: 1
      prefix: "-nb-cores"
  - id: verbose
    type: ['null', int]
    doc: "Verbosity level [default 1]"
    inputBinding:
      position: 1
      prefix: "-verbose"
  - id: input_file
    type: File
    doc: "Input file (FASTA or FASTQ, gzipped or not)"
    inputBinding:
      position: 1
      prefix: "-file"
  - id: kmer_size
    type: int
    doc: "k-mer size (k < 15)"
    inputBinding:
      position: 1
      prefix: "-kmer-size"
  - id: output_file_name
    type: ['null', string]
    default: "kmerinshort_counts.txt"
    doc: "Output file"
    inputBinding:
      position: 1
      prefix: "-out"
  - id: offset
    type: ['null', int]
    doc: "Starting offset [default 0]"
    inputBinding:
      position: 1
      prefix: "-offset"
  - id: step
    type: ['null', int]
    doc: "Step [default 1]"
    inputBinding:
      position: 1
      prefix: "-step"
  - id: kval
    type: ['null', File]
    doc: "File with kmer values"
    inputBinding:
      position: 1
      prefix: "-kval"
  - id: dont_reverse
    type: ['null', boolean]
    doc: "Do not reverse kmers, count forward and reverse complement separately"
    inputBinding:
      position: 1
      prefix: "-dont-reverse"
  - id: freq
    type: ['null', boolean]
    doc: "Output frequency"
    inputBinding:
      position: 1
      prefix: "-freq"
  - id: per_seq
    type: ['null', boolean]
    doc: "One output file and count per fasta sequence"
    inputBinding:
      position: 1
      prefix: "-perSeq"
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Output file(s) written with -out (several with -perSeq)"
    outputBinding:
      glob:
        - $(inputs.output_file_name)*
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerinshort:1.0.1--0
stdout: kmerinshort.out
