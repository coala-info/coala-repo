cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - makebv
label: howdesbt_makebv
doc: "convert a sequence file to a bit vector\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: "sequence files, e.g. fasta or fastq (one bit vector is created, for the union of the sequence files)"
    inputBinding:
      position: 1
  - id: out
    type: string
    doc: "name for bit vector file; the compression type is determined by the file extension (.bv, .rrr or .roar)"
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
  - id: asper
    type:
      - 'null'
      - File
    doc: "name of an existing bloom filter file to extract settings from; that file's --k, --seed, and --bits will be used if they are not otherwise specified"
    inputBinding:
      position: 104
      prefix: "--asper="
      separate: false
  - id: k
    type:
      - 'null'
      - int
    doc: "kmer size (number of nucleotides in a kmer) (default is 20)"
    inputBinding:
      position: 105
      prefix: "--k="
      separate: false
  - id: min
    type:
      - 'null'
      - int
    doc: "kmers occuring fewer than N times are left out of the bit vector (default is 1)"
    inputBinding:
      position: 106
      prefix: "--min="
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use during kmerization (default is 1)"
    inputBinding:
      position: 107
      prefix: "--threads="
      separate: false
  - id: seed
    type:
      - 'null'
      - string
    doc: "the hash function's 64-bit seed"
    inputBinding:
      position: 108
      prefix: "--seed="
      separate: false
  - id: bits
    type:
      - 'null'
      - int
    doc: "number of bits in the bit vector (default is 500000)"
    inputBinding:
      position: 109
      prefix: "--bits="
      separate: false
outputs:
  - id: bit_vector
    type: File
    doc: "bit vector file"
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
