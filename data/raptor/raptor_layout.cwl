cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - raptor
  - layout
label: raptor_layout
doc: "Computes an HIBF layout that tries to minimize the disk space consumption of\
  \ the resulting index. Pass the resulting layout to raptor build.\n\nTool homepage:\
  \ https://github.com/seqan/raptor"
inputs:
  - id: input_file
    type: File
    doc: 'The input must be a file containing paths to sequence data you wish to estimate;
      one filepath per line. If your file contains auxiliary information (e.g. species
      IDs), your file must be tab-separated. Example file: ``` /absolute/path/to/file1.fasta
      /absolute/path/to/file2.fa.gz ```'
    inputBinding:
      position: 101
      prefix: --input-file
      valueFrom: $(self.basename)
  - id: bin_files
    type:
      type: array
      items: File
    doc: Sequence files (or minimiser files) named in the input file; staged in the
      working directory so the names resolve
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'The k-mer size influences the size estimates of the input. Choosing a k-mer
      size that is too small for your data will result in files appearing more similar
      than they really are. Likewise, a large k-mer size might miss out on certain
      similarities. For DNA sequences, a k-mer size between [16,32] has proven to
      work well. Default: 19.'
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: tmax
    type:
      - 'null'
      - int
    doc: "Limits the number of technical bins on each level of the HIBF. Choosing\
      \ a good tmax is not trivial. The smaller tmax, the more levels the layout needs\
      \ to represent the data. This results in a higher space consumption of the index.\
      \ While querying each individual level is cheap, querying many levels might\
      \ also lead to an increased runtime. A good tmax is usually the square root\
      \ of the number of user bins/samples rounded to the next multiple of 64. Note\
      \ that your tmax will always be rounded to the next multiple of 64. At the expense\
      \ of a longer runtime, you can enable the statistic mode that determines the\
      \ best tmax for your data set. See the advanced option --determine-best-tmax\
      \ Default: \u2248sqrt(#samples)."
    inputBinding:
      position: 101
      prefix: --tmax
  - id: num_hash_functions
    type:
      - 'null'
      - int
    doc: 'The number of hash functions to use when building the HIBF from the resulting
      layout. This parameter is needed to correctly estimate the index size when computing
      the layout. Default: 2.'
    inputBinding:
      position: 101
      prefix: --num-hash-functions
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: 'The false positive rate you aim for when building the HIBF from the resulting
      layout. This parameter is needed to correctly estimate the index size when computing
      the layout. Default: 0.05.'
    inputBinding:
      position: 101
      prefix: --false-positive-rate
  - id: output_filename
    type:
      - 'null'
      - string
    doc: 'A file name for the resulting layout. Default: "binning.out".'
    default: binning.out
    inputBinding:
      position: 101
      prefix: --output-filename
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use. Currently, only merging of sketches is parallelized,
      so if the flag --disable-rearrangement is set, --threads will have no effect.
      Default: 1. Value must be in range [1,18446744073709551615].'
    inputBinding:
      position: 101
      prefix: --threads
  - id: disable_estimate_union
    type:
      - 'null'
      - boolean
    doc: 'The sketches are used to estimate the sequence similarity among a set of
      user bins. This will improve the layout computation as merging user bins that
      do not increase technical bin sizes will be preferred. This may use more RAM
      and can be disabled in RAM-critical environments. Attention: Also disables rearrangement
      which depends on union estimations.'
    inputBinding:
      position: 101
      prefix: --disable-estimate-union
  - id: disable_rearrangement
    type:
      - 'null'
      - boolean
    doc: As a preprocessing step, rearranging the order of the given user bins based
      on their sequence similarity may lead to favourable small unions and thus a
      smaller index. Depending on the number of input samples (user bins), this may
      be time-consuming and can thus be disabled if a suboptimal layout is sufficient.
    inputBinding:
      position: 101
      prefix: --disable-rearrangement
  - id: alpha
    type:
      - 'null'
      - float
    doc: 'The layout algorithm optimizes the space consumption of the resulting HIBF
      but currently has no means of optimizing the runtime for querying such an HIBF.
      In general, the ratio of merged bins and split bins influences the query time
      because a merged bin always triggers another search on a lower level. To influence
      this ratio, alpha can be used. The higher alpha, the less merged bins are chosen
      in the layout. This improves query times but leads to a bigger index. Default:
      1.2.'
    inputBinding:
      position: 101
      prefix: --alpha
  - id: max_rearrangement_ratio
    type:
      - 'null'
      - float
    doc: 'When the flag --disable-rearrangement is not set, this option can influence
      the rearrangement algorithm. The algorithm only rearranges the order of user
      bins in fixed intervals. The higher --max-rearrangement-ratio, the larger the
      intervals. This potentially improves the layout, but increases the runtime of
      the layout algorithm. Default: 0.5. Value must be in range [0.000000,1.000000].'
    inputBinding:
      position: 101
      prefix: --max-rearrangement-ratio
  - id: sketch_bits
    type:
      - 'null'
      - int
    doc: 'The number of bits the HyperLogLog sketch should use to distribute the values
      into bins. Default: 12. Value must be in range [5,32].'
    inputBinding:
      position: 101
      prefix: --sketch-bits
  - id: determine_best_tmax
    type:
      - 'null'
      - boolean
    doc: When this flag is set, the program will compute multiple layouts for tmax
      in [64 , 128, 256, ... , tmax] as well as tmax=sqrt(#samples). The layout algorithm
      itself only optimizes the space consumption. When determining the best layout,
      we additionally keep track of the average number of queries needed to traverse
      each layout. This query cost is taken into account when determining the best
      tmax for your data. Note that the option --tmax serves as upper bound. Once
      the layout quality starts dropping, the computation is stopped. To run all layout
      computations, pass the flag --force-all-binnings.
    inputBinding:
      position: 101
      prefix: --determine-best-tmax
  - id: force_all_binnings
    type:
      - 'null'
      - boolean
    doc: Forces all layouts up to --tmax to be computed, regardless of the layout
      quality. If the flag --determine-best-tmax is not set, this flag is ignored
      and has no effect.
    inputBinding:
      position: 101
      prefix: --force-all-binnings
  - id: output_sketches_to
    type:
      - 'null'
      - string
    doc: 'If you supply a directory path with this option, the hyperloglog sketches
      of your input will be stored in the respective path; one .hll file per input
      file. Default: None.'
    inputBinding:
      position: 101
      prefix: --output-sketches-to
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (time and memory usage)
  - id: layout_file
    type: File
    doc: The HIBF layout
    outputBinding:
      glob: $(inputs.output_filename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)
      - $(inputs.bin_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor_layout.out
