cwlVersion: v1.2
class: CommandLineTool
baseCommand: mash sketch
label: mash_sketch
doc: "Create a sketch file, which is a reduced representation of a sequence or set
  of sequences (based on min-hashes) that can be used for fast distance estimations.
  Inputs can be fasta or fastq files (gzipped or not), and \"-\" can be given to read
  from standard input. Input files can also be files of file names (see -l). For output,
  one sketch file will be generated, but it can have multiple sketches within it,
  divided by sequences or files (see -i). By default, the output file name will be
  the first input file with a '.msh' extension, or 'stdin.msh' if standard input is
  used (see -o).\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input sequence files or files of file names
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Alphabet to base hashes on (case ignored by default; see -Z). K-mers 
      with other characters will be ignored. Implies -n.
    inputBinding:
      position: 102
      prefix: -z
  - id: amino_acid_alphabet
    type:
      - 'null'
      - boolean
    doc: Use amino acid alphabet (A-Z, except BJOUXZ). Implies -n, -k 9.
    inputBinding:
      position: 102
      prefix: -a
  - id: bloom_filter_size
    type:
      - 'null'
      - string
    doc: Use a Bloom filter of this size (raw bytes or with K/M/G/T) to filter 
      out unique k-mers. This is useful if exact filtering with -m uses too much
      memory. However, some unique k-mers may pass erroneously, and copies 
      cannot be counted beyond 2. Implies -r.
    inputBinding:
      position: 102
      prefix: -b
  - id: comment
    type:
      - 'null'
      - string
    doc: Comment for a sketch of reads (instead of first sequence comment).
    inputBinding:
      position: 102
      prefix: -C
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Genome size (raw bases or with K/M/G/T). If specified, will be used for
      p-value calculation instead of an estimated size from k-mer content. 
      Implies -r.
    inputBinding:
      position: 102
      prefix: -g
  - id: id_field
    type:
      - 'null'
      - string
    doc: ID field for sketch of reads (instead of first sequence ID).
    inputBinding:
      position: 102
      prefix: -I
  - id: input_is_read_set
    type:
      - 'null'
      - boolean
    doc: Input is a read set. See Reads options below. Incompatible with -i.
    inputBinding:
      position: 102
      prefix: -r
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size. Hashes will be based on strings of this many nucleotides. 
      Canonical nucleotides are used by default (see Alphabet options below). 
      (1-32)
    default: 21
    inputBinding:
      position: 102
      prefix: -k
  - id: list_input
    type:
      - 'null'
      - boolean
    doc: List input. Lines in each <input> specify paths to sequence files, one 
      per line.
    inputBinding:
      position: 102
      prefix: -l
  - id: min_kmer_copies
    type:
      - 'null'
      - int
    doc: Minimum copies of each k-mer required to pass noise filter for reads. 
      Implies -r.
    default: 1
    inputBinding:
      position: 102
      prefix: -m
  - id: parallelism
    type:
      - 'null'
      - int
    doc: Parallelism. This many threads will be spawned for processing.
    default: 1
    inputBinding:
      position: 102
      prefix: -p
  - id: preserve_case
    type:
      - 'null'
      - boolean
    doc: Preserve case in k-mers and alphabet (case is ignored by default). 
      Sequence letters whose case is not in the current alphabet will be skipped
      when sketching.
    inputBinding:
      position: 102
      prefix: -Z
  - id: preserve_strand
    type:
      - 'null'
      - boolean
    doc: Preserve strand (by default, strand is ignored by using canonical DNA 
      k-mers, which are alphabetical minima of forward-reverse pairs). Implied 
      if an alphabet is specified with -a or -z.
    inputBinding:
      position: 102
      prefix: -n
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed to provide to the hash function. (0-4294967296)
    default: 42
    inputBinding:
      position: 102
      prefix: -S
  - id: sketch_individual_sequences
    type:
      - 'null'
      - boolean
    doc: Sketch individual sequences, rather than whole files, e.g. for 
      multi-fastas of single-chromosome genomes or pair-wise gene comparisons.
    inputBinding:
      position: 102
      prefix: -i
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size. Each sketch will have at most this many non-redundant 
      min-hashes.
    default: 1000
    inputBinding:
      position: 102
      prefix: -s
  - id: target_coverage
    type:
      - 'null'
      - string
    doc: Target coverage. Sketching will conclude if this coverage is reached 
      before the end of the input file (estimated by average k-mer 
      multiplicity). Implies -r.
    inputBinding:
      position: 102
      prefix: -c
  - id: warning_threshold
    type:
      - 'null'
      - float
    doc: Probability threshold for warning about low k-mer size. (0-1)
    default: 0.01
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output prefix (first input file used if unspecified). The suffix '.msh'
      will be appended.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
