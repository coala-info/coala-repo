cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar RNA-Bloom.jar
label: rnabloom
doc: "RNA-Bloom v2.0.1\n\nTool homepage: https://github.com/bcgsc/RNA-Bloom"
inputs:
  - id: assembly_name
    type:
      - 'null'
      - string
    doc: assembly name
    default: rnabloom
    inputBinding:
      position: 101
      prefix: --name
  - id: assembly_stage
    type:
      - 'null'
      - int
    doc: assembly termination stage
    inputBinding:
      position: 101
      prefix: -stage
  - id: cbf_hash
    type:
      - 'null'
      - int
    doc: number of hash functions for k-mer counting Bloom filter
    default: 2
    inputBinding:
      position: 101
      prefix: --cbf-hash
  - id: cbf_memory_gb
    type:
      - 'null'
      - float
    doc: amount of memory (GB) for k-mer counting Bloom filter
    default: auto
    inputBinding:
      position: 101
      prefix: --cbf-mem
  - id: count_unique_kmers_ntcard
    type:
      - 'null'
      - boolean
    doc: count unique k-mers in input reads with ntCard
    inputBinding:
      position: 101
      prefix: --ntcard
  - id: dbgbf_hash
    type:
      - 'null'
      - int
    doc: number of hash functions for de Bruijn graph Bloom filter
    default: 2
    inputBinding:
      position: 101
      prefix: --dbgbf-hash
  - id: dbgbf_memory_gb
    type:
      - 'null'
      - float
    doc: amount of memory (GB) for de Bruijn graph Bloom filter
    default: auto
    inputBinding:
      position: 101
      prefix: --dbgbf-mem
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debugging information
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_fragment_consistency
    type:
      - 'null'
      - boolean
    doc: turn off assembly consistency with fragment paired k-mers
    default: false
    inputBinding:
      position: 101
      prefix: --nofc
  - id: error_correction_iterations
    type:
      - 'null'
      - int
    doc: number of iterations of error-correction in reads
    default: 1
    inputBinding:
      position: 101
      prefix: --errcorritr
  - id: expected_num_kmers
    type:
      - 'null'
      - int
    doc: expected number of unique k-mers in input reads
    inputBinding:
      position: 101
      prefix: --num-kmers
  - id: extend_fragments
    type:
      - 'null'
      - boolean
    doc: extend fragments outward during fragment reconstruction
    default: false
    inputBinding:
      position: 101
      prefix: --extend
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: force overwrite existing files
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: header_prefix
    type:
      - 'null'
      - string
    doc: name prefix in FASTA header for assembled transcripts
    inputBinding:
      position: 101
      prefix: --prefix
  - id: keep_artifacts
    type:
      - 'null'
      - boolean
    doc: keep potential sequencing artifacts
    default: false
    inputBinding:
      position: 101
      prefix: --artifact
  - id: keep_chimeras
    type:
      - 'null'
      - boolean
    doc: keep potential chimeras
    default: false
    inputBinding:
      position: 101
      prefix: --chimera
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 25
    inputBinding:
      position: 101
      prefix: --kmer
  - id: left_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: left reads file(s)
    inputBinding:
      position: 101
      prefix: --left
  - id: long_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: long reads file(s)
    inputBinding:
      position: 101
  - id: lookahead_kmers
    type:
      - 'null'
      - int
    doc: number of k-mers to look ahead during graph traversal
    default: 3
    inputBinding:
      position: 101
      prefix: --lookahead
  - id: max_coverage_gradient
    type:
      - 'null'
      - float
    doc: maximum k-mer coverage gradient for error correction
    default: 0.5
    inputBinding:
      position: 101
      prefix: --maxcovgrad
  - id: max_fpr
    type:
      - 'null'
      - float
    doc: maximum allowable false-positive rate of Bloom filters
    default: 0.01
    inputBinding:
      position: 101
      prefix: --fpr
  - id: max_indel_size
    type:
      - 'null'
      - int
    doc: maximum size of indels to be collapsed
    default: 1
    inputBinding:
      position: 101
      prefix: --indel
  - id: max_mate_distance
    type:
      - 'null'
      - int
    doc: maximum distance between read mates
    default: 500
    inputBinding:
      position: 101
      prefix: --bound
  - id: max_tip_length
    type:
      - 'null'
      - int
    doc: maximum number of bases in a tip
    default: auto
    inputBinding:
      position: 101
      prefix: --tiplength
  - id: merge_pooled_assemblies
    type:
      - 'null'
      - boolean
    doc: merge pooled assemblies
    default: false
    inputBinding:
      position: 101
      prefix: --mergepool
  - id: min_avg_base_quality
    type:
      - 'null'
      - int
    doc: minimum average base quality in reads
    default: 0
    inputBinding:
      position: 101
      prefix: --qual-avg
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: minimum base quality in reads
    default: 3
    inputBinding:
      position: 101
      prefix: --qual
  - id: min_consecutive_kmer_pairs
    type:
      - 'null'
      - int
    doc: minimum number of consecutive k-mer pairs for assembling transcripts
    default: 10
    inputBinding:
      position: 101
      prefix: --pair
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: minimum k-mer coverage
    default: 1
    inputBinding:
      position: 101
      prefix: --mincov
  - id: min_long_read_depth
    type:
      - 'null'
      - int
    doc: min read depth required for long-read assembly
    default: 3
    inputBinding:
      position: 101
      prefix: -lrrd
  - id: min_long_read_overlap_proportion
    type:
      - 'null'
      - float
    doc: minimum proportion of matching bases within long-read overlaps
    default: 0.8
    inputBinding:
      position: 101
      prefix: -lrop
  - id: min_overlap_bases
    type:
      - 'null'
      - int
    doc: minimum number of overlapping bases between reads
    default: k-1
    inputBinding:
      position: 101
      prefix: --overlap
  - id: min_percent_identity
    type:
      - 'null'
      - float
    doc: minimum percent identity of sequences to be collapsed
    default: 0.9
    inputBinding:
      position: 101
      prefix: --percent
  - id: min_transcript_length
    type:
      - 'null'
      - int
    doc: minimum transcript length in output assembly
    default: 200
    inputBinding:
      position: 101
      prefix: --length
  - id: minimap2_options
    type:
      - 'null'
      - string
    doc: options for minimap2
    default: "\"'-K 250M -e 25 -f 0.0001 -c'\""
    inputBinding:
      position: 101
      prefix: -mmopt
  - id: num_hash_functions
    type:
      - 'null'
      - int
    doc: number of hash functions for all Bloom filters
    default: 2
    inputBinding:
      position: 101
      prefix: -hash
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    default: //rnabloom_assembly
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pkbf_hash
    type:
      - 'null'
      - int
    doc: number of hash functions for paired k-mers Bloom filter
    default: 2
    inputBinding:
      position: 101
      prefix: --pkbf-hash
  - id: pkbf_memory_gb
    type:
      - 'null'
      - float
    doc: amount of memory (GB) for paired kmers Bloom filter
    default: auto
    inputBinding:
      position: 101
      prefix: --pkbf-mem
  - id: poly_a_length
    type:
      - 'null'
      - int
    doc: prioritize assembly of transcripts with poly-A tails of the minimum 
      length specified
    default: 0
    inputBinding:
      position: 101
      prefix: --polya
  - id: pool_file
    type:
      - 'null'
      - File
    doc: list of read files for pooled assembly
    inputBinding:
      position: 101
  - id: reference_transcripts
    type:
      - 'null'
      - type: array
        items: File
    doc: reference transcripts file(s) for guiding the assembly process
    inputBinding:
      position: 101
  - id: revcomp_left
    type:
      - 'null'
      - boolean
    doc: reverse-complement left reads
    default: false
    inputBinding:
      position: 101
      prefix: --revcomp-left
  - id: revcomp_long
    type:
      - 'null'
      - boolean
    doc: reverse-complement long reads
    default: false
    inputBinding:
      position: 101
      prefix: --revcomp-long
  - id: revcomp_right
    type:
      - 'null'
      - boolean
    doc: reverse-complement right reads
    default: false
    inputBinding:
      position: 101
      prefix: --revcomp-right
  - id: right_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: right reads file(s)
    inputBinding:
      position: 101
      prefix: --right
  - id: sample_size
    type:
      - 'null'
      - int
    doc: sample size for estimating read/fragment lengths
    default: 10000
    inputBinding:
      position: 101
      prefix: --sample
  - id: save_bloom_filters
    type:
      - 'null'
      - boolean
    doc: save graph (Bloom filters) from stage 1 to disk
    default: false
    inputBinding:
      position: 101
      prefix: --savebf
  - id: sbf_memory_gb
    type:
      - 'null'
      - float
    doc: amount of memory (GB) for screening Bloom filter
    default: auto
    inputBinding:
      position: 101
      prefix: --sbf-mem
  - id: screening_bf_hash
    type:
      - 'null'
      - int
    doc: number of hash functions for screening Bloom filter
    default: 2
    inputBinding:
      position: 101
      prefix: --sbf-hash
  - id: sensitive_assembly
    type:
      - 'null'
      - boolean
    doc: assemble transcripts in sensitive mode
    default: false
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: single_end_forward
    type:
      - 'null'
      - type: array
        items: File
    doc: single-end forward read file(s)
    inputBinding:
      position: 101
  - id: single_end_reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: single-end reverse read file(s)
    inputBinding:
      position: 101
  - id: skip_redundancy_reduction
    type:
      - 'null'
      - boolean
    doc: skip redundancy reduction for assembled transcripts
    default: false
    inputBinding:
      position: 101
      prefix: --norr
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: reads are strand specific
    default: false
    inputBinding:
      position: 101
      prefix: --stranded
  - id: stratum
    type:
      - 'null'
      - string
    doc: fragments lower than the specified stratum are extended only if they 
      are branch-free in the graph
    default: e0
    inputBinding:
      position: 101
      prefix: --stratum
  - id: subsample_long_reads
    type:
      - 'null'
      - string
    doc: subsample long reads before assembly using strobemers 
      (depth,s,size,window) or k-mer pairs (depth,k,size)
    default: '[3,s,11,50]'
    inputBinding:
      position: 101
      prefix: -lrsub
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to run
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
  - id: total_memory_gb
    type:
      - 'null'
      - float
    doc: total amount of memory (GB) for all Bloom filters
    default: auto
    inputBinding:
      position: 101
      prefix: --memory
  - id: uracil
    type:
      - 'null'
      - boolean
    doc: output uracils (U) in place of thymines (T) in assembled transcripts
    default: false
    inputBinding:
      position: 101
      prefix: --uracil
  - id: use_pacbio_presets
    type:
      - 'null'
      - boolean
    doc: use PacBio presets
    default: false
    inputBinding:
      position: 101
      prefix: -lrpb
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabloom:2.0.1--hdfd78af_1
stdout: rnabloom.out
