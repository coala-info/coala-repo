cwlVersion: v1.2
class: CommandLineTool
baseCommand: howdesbt_makebf
label: howdesbt_makebf
doc: "convert a sequence file to a bloom filter\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: a sequence file, e.g. fasta, fastq, or kmers (one bloom filter is 
      created, for the union of the sequence files)
    inputBinding:
      position: 1
  - id: asper_file
    type:
      - 'null'
      - File
    doc: name of an existing bloom filter file to extract settings from; that 
      file's --k, --hashes, --seed, --modulus, --bits and compression type will 
      be used if they are not otherwise specified on the command line
    inputBinding:
      position: 102
      prefix: --asper
  - id: hash_seed_1
    type:
      - 'null'
      - int
    doc: the hash function's 56-bit seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: hash_seed_2
    type:
      - 'null'
      - int
    doc: the second hash function seed (only used if more than one hash function
      is being used)
    inputBinding:
      position: 102
      prefix: --seed
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size (number of nucleotides in a kmer)
    default: 20
    inputBinding:
      position: 102
      prefix: --k
  - id: kmersin
    type:
      - 'null'
      - boolean
    doc: input files are kmers (by default input files are expected to be fasta 
      or fastq)
    inputBinding:
      position: 102
      prefix: --kmersin
  - id: list_file
    type:
      - 'null'
      - File
    doc: file containing a list of bloom filters to create; this is used in 
      place of the <filename>s on the command line; the file format is described
      below
    inputBinding:
      position: 102
      prefix: --list
  - id: min_occurrence
    type:
      - 'null'
      - int
    doc: kmers occuring fewer than N times are left out of the bloom filter; 
      this does not apply when --kmersin is used
    default: 1
    inputBinding:
      position: 102
      prefix: --min
  - id: modulus
    type:
      - 'null'
      - int
    doc: set the hash modulus, if larger than the number of bits (by default 
      this is the same as the number of bits)
    inputBinding:
      position: 102
      prefix: --modulus
  - id: num_bits
    type:
      - 'null'
      - int
    doc: number of bits in the bloom filter
    default: 500000
    inputBinding:
      position: 102
      prefix: --bits
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: how many hash functions to use for the filter
    default: 1
    inputBinding:
      position: 102
      prefix: --hashes
  - id: roar_compressed
    type:
      - 'null'
      - boolean
    doc: make the filter with roar-compressed bit vector(s)
    inputBinding:
      position: 102
      prefix: --roar
  - id: rrr_compressed
    type:
      - 'null'
      - boolean
    doc: make the filter with RRR-compressed bit vector(s)
    inputBinding:
      position: 102
      prefix: --rrr
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use during kmerization
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: make the filter with uncompressed bit vector(s) (this is the default)
    inputBinding:
      position: 102
      prefix: --uncompressed
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: name for bloom filter file (by default this is derived from first 
      sequence filename)
    outputBinding:
      glob: $(inputs.output_filename)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: write bloom filter stats to a text file (if no filename is given this 
      is derived from the bloom filter filename)
    outputBinding:
      glob: $(inputs.stats_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
