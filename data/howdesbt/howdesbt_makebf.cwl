cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - makebf
label: howdesbt_makebf
doc: "convert a sequence file to a bloom filter\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: "a sequence file, e.g. fasta, fastq, or kmers (one bloom filter is created, for the union of the sequence files)"
    inputBinding:
      position: 1
  - id: out
    type: string
    doc: "name for bloom filter file (by default this is derived from first sequence filename)"
    inputBinding:
      position: 102
      prefix: "--out="
      separate: false
  - id: kmersin
    type:
      - 'null'
      - boolean
    doc: "input files are kmers (by default input files are expected to be fasta or fastq)"
    inputBinding:
      position: 103
      prefix: "--kmersin"
  - id: list_file
    type:
      - 'null'
      - File
    doc: "file containing a list of bloom filters to create; this is used in place of the sequence files on the command line"
    inputBinding:
      position: 104
      prefix: "--list="
      separate: false
  - id: asper
    type:
      - 'null'
      - File
    doc: "name of an existing bloom filter file to extract settings from; that file's --k, --hashes, --seed, --modulus, --bits and compression type will be used if they are not otherwise specified on the command line"
    inputBinding:
      position: 105
      prefix: "--asper="
      separate: false
  - id: k
    type:
      - 'null'
      - int
    doc: "kmer size (number of nucleotides in a kmer) (default is 20)"
    inputBinding:
      position: 106
      prefix: "--k="
      separate: false
  - id: min
    type:
      - 'null'
      - int
    doc: "kmers occuring fewer than N times are left out of the bloom filter; this does not apply when --kmersin is used (default is 1)"
    inputBinding:
      position: 107
      prefix: "--min="
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use during kmerization (default is 1)"
    inputBinding:
      position: 108
      prefix: "--threads="
      separate: false
  - id: hashes
    type:
      - 'null'
      - int
    doc: "how many hash functions to use for the filter (default is 1)"
    inputBinding:
      position: 109
      prefix: "--hashes="
      separate: false
  - id: seed
    type:
      - 'null'
      - string
    doc: "the hash function's 56-bit seed; either one number or two numbers separated by a comma (the second seed is only used if more than one hash function is being used)"
    inputBinding:
      position: 110
      prefix: "--seed="
      separate: false
  - id: modulus
    type:
      - 'null'
      - int
    doc: "set the hash modulus, if larger than the number of bits (by default this is the same as the number of bits)"
    inputBinding:
      position: 111
      prefix: "--modulus="
      separate: false
  - id: bits
    type:
      - 'null'
      - int
    doc: "number of bits in the bloom filter (default is 500000)"
    inputBinding:
      position: 112
      prefix: "--bits="
      separate: false
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: "make the filter with uncompressed bit vector(s) (this is the default)"
    inputBinding:
      position: 113
      prefix: "--uncompressed"
  - id: rrr
    type:
      - 'null'
      - boolean
    doc: "make the filter with RRR-compressed bit vector(s)"
    inputBinding:
      position: 114
      prefix: "--rrr"
  - id: roar
    type:
      - 'null'
      - boolean
    doc: "make the filter with roar-compressed bit vector(s)"
    inputBinding:
      position: 115
      prefix: "--roar"
  - id: stats
    type:
      - 'null'
      - string
    doc: "name of a text file to write bloom filter stats to"
    inputBinding:
      position: 116
      prefix: "--stats="
      separate: false
outputs:
  - id: bloom_filter
    type:
      - 'null'
      - File
    doc: "bloom filter file"
    outputBinding:
      glob: $(inputs.out)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: "bloom filter stats text file"
    outputBinding:
      glob: $(inputs.stats)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
