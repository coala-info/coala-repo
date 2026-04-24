cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmon_index
label: salmon_index
doc: "Creates a salmon index.\n\nTool homepage: https://github.com/COMBINE-lab/salmon"
inputs:
  - id: decoys
    type:
      - 'null'
      - File
    doc: Treat these sequences ids from the reference as the decoys that may 
      have sequence homologous to some known transcript. for example in case of 
      the genome, provide a list of chromosome name --- one per line
    inputBinding:
      position: 101
      prefix: --decoys
  - id: features
    type:
      - 'null'
      - boolean
    doc: This flag will expect the input reference to be in the tsv file format,
      and will split the feature name at the first 'tab' character. These 
      reduced names will be used in the output and when looking for the sequence
      of the features.GTF.
    inputBinding:
      position: 101
      prefix: --features
  - id: filter_size
    type:
      - 'null'
      - int
    doc: The size of the Bloom filter that will be used by TwoPaCo during 
      indexing. The filter will be of size 2^{filterSize}. The default value of 
      -1 means that the filter size will be automatically set based on the 
      number of distinct k-mers in the input, as estimated by nthll.
    inputBinding:
      position: 101
      prefix: --filterSize
  - id: gencode
    type:
      - 'null'
      - boolean
    doc: This flag will expect the input transcript fasta to be in GENCODE 
      format, and will split the transcript name at the first '|' character. 
      These reduced names will be used in the output and when looking for these 
      transcripts in a gene to transcript GTF.
    inputBinding:
      position: 101
      prefix: --gencode
  - id: index
    type: Directory
    doc: salmon index.
    inputBinding:
      position: 101
      prefix: --index
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: This flag will disable the default indexing behavior of discarding 
      sequence-identical duplicate transcripts. If this flag is passed, then 
      duplicate transcripts that appear in the input will be retained and 
      quantified separately.
    inputBinding:
      position: 101
      prefix: --keepDuplicates
  - id: keep_fixed_fasta
    type:
      - 'null'
      - boolean
    doc: Retain the fixed fasta file (without short transcripts and duplicates, 
      clipped, etc.) generated during indexing
    inputBinding:
      position: 101
      prefix: --keepFixedFasta
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: The size of k-mers that should be used for the quasi index.
    inputBinding:
      position: 101
      prefix: --kmerLen
  - id: no_clip
    type:
      - 'null'
      - boolean
    doc: Don't clip poly-A tails from the ends of target sequences
    inputBinding:
      position: 101
      prefix: --no-clip
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: Build the index using a sparse sampling of k-mer positions This will 
      require less memory (especially during quantification), but will take 
      longer to construct and can slow down mapping / alignment
    inputBinding:
      position: 101
      prefix: --sparse
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use during indexing.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: The directory location that will be used for TwoPaCo temporary files; 
      it will be created if need be and be removed prior to indexing completion.
      The default value will cause a (temporary) subdirectory of the salmon 
      index directory to be used for this purpose.
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: transcripts
    type: File
    doc: Transcript fasta file.
    inputBinding:
      position: 101
      prefix: --transcripts
  - id: type
    type:
      - 'null'
      - string
    doc: The type of index to build; the only option is "puff" in this version 
      of salmon.
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
stdout: salmon_index.out
