cwlVersion: v1.2
class: CommandLineTool
baseCommand: oarfish
label: oarfish
doc: "A fast, accurate and versatile tool for long-read transcript quantification.\n\
  \nTool homepage: https://github.com/COMBINE-lab/oarfish"
inputs:
  - id: alignments
    type:
      - 'null'
      - File
    doc: path to the file containing the input alignments
    inputBinding:
      position: 101
      prefix: --alignments
  - id: annotated
    type:
      - 'null'
      - File
    doc: path to the file containing the annotated transcriptome (e.g. GENCODE) 
      against which to map
    inputBinding:
      position: 101
      prefix: --annotated
  - id: best_n
    type:
      - 'null'
      - int
    doc: maximum number of secondary mappings to consider when mapping reads to 
      the transcriptome
    inputBinding:
      position: 101
      prefix: --best-n
  - id: bin_width
    type:
      - 'null'
      - int
    doc: width of the bins used in the coverage model
    inputBinding:
      position: 101
      prefix: --bin-width
  - id: convergence_thresh
    type:
      - 'null'
      - float
    doc: maximum number of iterations for which to run the EM algorithm
    inputBinding:
      position: 101
      prefix: --convergence-thresh
  - id: display_thresh
    type:
      - 'null'
      - string
    doc: minimum posterior probability threshold for a read-transcript 
      assignment to be written to the .prob file. Accepts a float value between 
      0.0 and 1.0, or the sentinel value 'none' to use the minimum machine 
      precision (f64::MIN_POSITIVE)
    inputBinding:
      position: 101
      prefix: --display-thresh
  - id: filter_group
    type:
      - 'null'
      - string
    doc: '[possible values: no-filters, nanocount-filters]'
    inputBinding:
      position: 101
      prefix: --filter-group
  - id: five_prime_clip
    type:
      - 'null'
      - int
    doc: maximum allowable distance of the left-most end of an alignment from 
      the 5' transcript end
    inputBinding:
      position: 101
      prefix: --five-prime-clip
  - id: growth_rate
    type:
      - 'null'
      - int
    doc: if using the coverage model, use this as the value of `k` in the 
      logistic equation
    inputBinding:
      position: 101
      prefix: --growth-rate
  - id: index
    type:
      - 'null'
      - File
    doc: path to an existing minimap2 index (either created with oarfish, which 
      is preferred, or with minimap2 itself)
    inputBinding:
      position: 101
      prefix: --index
  - id: index_out
    type:
      - 'null'
      - Directory
    doc: path where minimap2 index will be written (if provided)
    inputBinding:
      position: 101
      prefix: --index-out
  - id: max_em_iter
    type:
      - 'null'
      - int
    doc: maximum number of iterations for which to run the EM algorithm
    inputBinding:
      position: 101
      prefix: --max-em-iter
  - id: min_aligned_fraction
    type:
      - 'null'
      - float
    doc: fraction of a query that must be mapped within an alignemnt to consider
      the alignemnt valid
    inputBinding:
      position: 101
      prefix: --min-aligned-fraction
  - id: min_aligned_len
    type:
      - 'null'
      - int
    doc: minimum number of nucleotides in the aligned portion of a read
    inputBinding:
      position: 101
      prefix: --min-aligned-len
  - id: model_coverage
    type:
      - 'null'
      - boolean
    doc: apply the coverage model
    inputBinding:
      position: 101
      prefix: --model-coverage
  - id: novel
    type:
      - 'null'
      - File
    doc: path to the file containing novel (de novo, or reference-guided 
      assembled) transcripts against which to map. These are ultimately indexed 
      together with reference transcripts, but passed in separately for the 
      purposes of provenance tracking
    inputBinding:
      position: 101
      prefix: --novel
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: number of bootstrap replicates to produce to assess quantification 
      uncertainty
    inputBinding:
      position: 101
      prefix: --num-bootstraps
  - id: only_index
    type:
      - 'null'
      - boolean
    doc: 'If this flag is passed, oarfish only performs indexing and not quantification.
      Designed primarily for workflow management systems. Note: A prebuilt index is
      not needed to quantify with oarfish; an index can be written concurrently with
      quantification using the `--index-out` parameter'
    inputBinding:
      position: 101
      prefix: --only-index
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet (i.e. don't output log messages that aren't at least warnings)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reads
    type:
      - 'null'
      - File
    doc: path to the file containing the input reads; these can be in FASTA/Q 
      format (possibly gzipped), or provided in uBAM (unaligned BAM) format. The
      format will be inferred from the file suffixes, and if a format cannot be 
      inferred, it will be assumed to be (possibly gzipped) FASTA/Q
    inputBinding:
      position: 101
      prefix: --reads
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: fraction of the best possible alignment score that a secondary 
      alignment must have for consideration
    inputBinding:
      position: 101
      prefix: --score-threshold
  - id: seq_tech
    type:
      - 'null'
      - string
    doc: 'sequencing technology in which to expect reads if using mapping based mode
      [possible values: ont-cdna, ont-drna, pac-bio, pac-bio-hifi]'
    inputBinding:
      position: 101
      prefix: --seq-tech
  - id: short_quant
    type:
      - 'null'
      - File
    doc: location of short read quantification (if provided)
    inputBinding:
      position: 101
      prefix: --short-quant
  - id: single_cell
    type:
      - 'null'
      - boolean
    doc: input is assumed to be a single-cell BAM and to have the `CB:z` tag for
      all read records
    inputBinding:
      position: 101
      prefix: --single-cell
  - id: strand_filter
    type:
      - 'null'
      - string
    doc: only alignments to this strand will be allowed; options are (fw /+, 
      rc/-, or both/.)
    inputBinding:
      position: 101
      prefix: --strand-filter
  - id: thread_buff_size
    type:
      - 'null'
      - string
    doc: 'total memory to allow for thread-local alignment buffers (each buffer will
      get this value / # of alignment threads)'
    inputBinding:
      position: 101
      prefix: --thread-buff-size
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of cores that oarfish will use during different phases of quantification.
      Note: This value will be at least 2 for bulk quantification and at least 3 for
      single-cell quantification due to the use of dedicated parsing threads'
    inputBinding:
      position: 101
      prefix: --threads
  - id: three_prime_clip
    type:
      - 'null'
      - int
    doc: maximum allowable distance of the right-most end of an alignment from 
      the 3' transcript end
    inputBinding:
      position: 101
      prefix: --three-prime-clip
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose (i.e. output all non-developer logging messages)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_assignment_probs
    type:
      - 'null'
      - string
    doc: write output alignment probabilites (optionally compressed) for each 
      mapped read. If <WRITE_ASSIGNMENT_PROBS> is present, it must be one of 
      `uncompressed` (default) or `compressed`, which will cause the output file
      to be lz4 compressed
    inputBinding:
      position: 101
      prefix: --write-assignment-probs
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: location where output quantification file should be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oarfish:0.9.3--h5ca1c30_0
