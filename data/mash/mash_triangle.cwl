cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mash
  - triangle
label: mash_triangle
doc: "Estimate the distance of each input sequence to every other input sequence.
  Outputs a lower-triangular distance matrix in relaxed Phylip format. The input sequences
  can be fasta or fastq, gzipped or not, or Mash sketch files (.msh) with matching
  k-mer sizes. Input files can also be files of file names (see -l). If more than
  one input file is provided, whole files are compared by default (see -i).\n\nTool
  homepage: https://github.com/marbl/Mash"
inputs:
  - id: seq1
    type: File
    doc: First input sequence file
    inputBinding:
      position: 1
  - id: seq2
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional input sequence files
    inputBinding:
      position: 2
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Alphabet to base hashes on (case ignored by default; see -Z). K-mers 
      with other characters will be ignored. Implies -n.
    inputBinding:
      position: 103
      prefix: -z
  - id: bloom_filter_size
    type:
      - 'null'
      - string
    doc: Use a Bloom filter of this size (raw bytes or with K/M/G/T) to filter 
      out unique k-mers. This is useful if exact filtering with -m uses too much
      memory. However, some unique k-mers may pass erroneously, and copies 
      cannot be counted beyond 2. Implies -r.
    inputBinding:
      position: 103
      prefix: -b
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Genome size (raw bases or with K/M/G/T). If specified, will be used for
      p-value calculation instead of an estimated size from k-mer content. 
      Implies -r.
    inputBinding:
      position: 103
      prefix: -g
  - id: hash_seed
    type:
      - 'null'
      - int
    doc: Seed to provide to the hash function. (0-4294967296)
    default: 42
    inputBinding:
      position: 103
      prefix: -S
  - id: input_is_read_set
    type:
      - 'null'
      - boolean
    doc: Input is a read set. See Reads options below. Incompatible with -i.
    inputBinding:
      position: 103
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
      position: 103
      prefix: -k
  - id: list_input
    type:
      - 'null'
      - boolean
    doc: List input. Lines in each <query> specify paths to sequence files, one 
      per line. The reference file is not affected.
    inputBinding:
      position: 103
      prefix: -l
  - id: max_distance
    type:
      - 'null'
      - float
    doc: Maximum distance to report in edge list. Implies -E. (0-1)
    default: 1.0
    inputBinding:
      position: 103
      prefix: -d
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: Maximum p-value to report in edge list. Implies -E. (0-1)
    default: 1.0
    inputBinding:
      position: 103
      prefix: -v
  - id: min_kmer_copies
    type:
      - 'null'
      - int
    doc: Minimum copies of each k-mer required to pass noise filter for reads. 
      Implies -r.
    default: 1
    inputBinding:
      position: 103
      prefix: -m
  - id: output_edge_list
    type:
      - 'null'
      - boolean
    doc: Output edge list instead of Phylip matrix, with fields [seq1, seq2, 
      dist, p-val, shared-hashes].
    inputBinding:
      position: 103
      prefix: -E
  - id: parallelism
    type:
      - 'null'
      - int
    doc: Parallelism. This many threads will be spawned for processing.
    default: 1
    inputBinding:
      position: 103
      prefix: -p
  - id: preserve_case
    type:
      - 'null'
      - boolean
    doc: Preserve case in k-mers and alphabet (case is ignored by default). 
      Sequence letters whose case is not in the current alphabet will be skipped
      when sketching.
    inputBinding:
      position: 103
      prefix: -Z
  - id: preserve_strand
    type:
      - 'null'
      - boolean
    doc: Preserve strand (by default, strand is ignored by using canonical DNA 
      k-mers, which are alphabetical minima of forward-reverse pairs). Implied 
      if an alphabet is specified with -a or -z.
    inputBinding:
      position: 103
      prefix: -n
  - id: sketch_individual_sequences
    type:
      - 'null'
      - boolean
    doc: Sketch individual sequences, rather than whole files, e.g. for 
      multi-fastas of single-chromosome genomes or pair-wise gene comparisons.
    inputBinding:
      position: 103
      prefix: -i
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size. Each sketch will have at most this many non-redundant 
      min-hashes.
    default: 1000
    inputBinding:
      position: 103
      prefix: -s
  - id: target_coverage
    type:
      - 'null'
      - float
    doc: Target coverage. Sketching will conclude if this coverage is reached 
      before the end of the input file (estimated by average k-mer 
      multiplicity). Implies -r.
    inputBinding:
      position: 103
      prefix: -c
  - id: use_amino_acid_alphabet
    type:
      - 'null'
      - boolean
    doc: Use amino acid alphabet (A-Z, except BJOUXZ). Implies -n, -k 9.
    inputBinding:
      position: 103
      prefix: -a
  - id: use_comment_fields
    type:
      - 'null'
      - boolean
    doc: Use comment fields for sequence names instead of IDs.
    inputBinding:
      position: 103
      prefix: -C
  - id: warning_pvalue_threshold
    type:
      - 'null'
      - float
    doc: Probability threshold for warning about low k-mer size. (0-1)
    default: 0.01
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_triangle.out
