cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbitqcplus
label: rabbitqcplus
doc: "RabbitQCPlus\n\nTool homepage: https://github.com/RabbitBio/RabbitQCPlus"
inputs:
  - id: adapter_fasta_file
    type:
      - 'null'
      - File
    doc: specify adapter sequences use fasta file
    inputBinding:
      position: 101
      prefix: --adapterFastaFile
  - id: adapter_seq1
    type:
      - 'null'
      - string
    doc: specify adapter sequence for read1
    inputBinding:
      position: 101
      prefix: --adapterSeq1
  - id: adapter_seq2
    type:
      - 'null'
      - string
    doc: specify adapter sequence for read2
    inputBinding:
      position: 101
      prefix: --adapterSeq2
  - id: add_umi
    type:
      - 'null'
      - boolean
    doc: do unique molecular identifier (umi) processing, default is off
    inputBinding:
      position: 101
      prefix: --addUmi
  - id: candidate_correction
    type:
      - 'null'
      - boolean
    doc: If set, candidate reads will be corrected,too, default is off
    inputBinding:
      position: 101
      prefix: --candidateCorrection
  - id: candidate_correction_new_columns
    type:
      - 'null'
      - int
    doc: If candidateCorrection is set, a candidates with an absolute shift of 
      candidateCorrectionNewColumns compared to anchor are corrected, default is
      15
    inputBinding:
      position: 101
      prefix: --candidateCorrectionNewColumns
  - id: compress_level
    type:
      - 'null'
      - int
    doc: output file compression level (1 - 9), default is 4
    inputBinding:
      position: 101
      prefix: --compressLevel
  - id: correct_data
    type:
      - 'null'
      - boolean
    doc: sample correcting low quality bases using information from overlap 
      (faster but less accurate), default is off
    inputBinding:
      position: 101
      prefix: --correctData
  - id: correct_with_care
    type:
      - 'null'
      - boolean
    doc: correct data use care engine (slower but much more accurate), default 
      is off
    inputBinding:
      position: 101
      prefix: --correctWithCare
  - id: correction_quality_labels
    type:
      - 'null'
      - boolean
    doc: If set, correction quality label will be appended to output read 
      headers, default is off
    inputBinding:
      position: 101
      prefix: --correctionQualityLabels
  - id: correction_type
    type:
      - 'null'
      - int
    doc: '0: Classic, 2: Print. Print is only supported in the cpu version, default
      is 0'
    inputBinding:
      position: 101
      prefix: --correctionType
  - id: correction_type_cands
    type:
      - 'null'
      - int
    doc: '0: Classic, 2: Print. Print is only supported in the cpu version, default
      is 0'
    inputBinding:
      position: 101
      prefix: --correctionTypeCands
  - id: coverage
    type:
      - 'null'
      - int
    doc: Estimated coverage of input file (i.e. number_of_reads * read_length / 
      genome_size)
    inputBinding:
      position: 101
      prefix: --coverage
  - id: coverage_factor_tuning
    type:
      - 'null'
      - float
    doc: coveragefactortuning, default is 0.6
    inputBinding:
      position: 101
      prefix: --coveragefactortuning
  - id: dec_ada_for_pe
    type:
      - 'null'
      - boolean
    doc: detect adapter for pe data, default is off, tool prefers to use overlap
      to find adapter
    inputBinding:
      position: 101
      prefix: --decAdaForPe
  - id: dec_ada_for_se
    type:
      - 'null'
      - boolean
    doc: detect adapter for se data, default is on
    inputBinding:
      position: 101
      prefix: --decAdaForSe
  - id: do_overrepresentation
    type:
      - 'null'
      - boolean
    doc: do over-representation sequence analysis, default is off
    inputBinding:
      position: 101
      prefix: --doOverrepresentation
  - id: enforce_hashmap_count
    type:
      - 'null'
      - boolean
    doc: If the requested number of hash maps cannot be fulfilled, the program 
      terminates without error correction, default is off
    inputBinding:
      position: 101
      prefix: --enforceHashmapCount
  - id: error_factor_tuning
    type:
      - 'null'
      - float
    doc: errorfactortuning, default is 0.06
    inputBinding:
      position: 101
      prefix: --errorfactortuning
  - id: exclude_ambiguous
    type:
      - 'null'
      - boolean
    doc: If set, reads which contain at least one ambiguous nucleotide will not 
      be corrected, default is off
    inputBinding:
      position: 101
      prefix: --excludeAmbiguous
  - id: fixed_number_of_reads
    type:
      - 'null'
      - int
    doc: Process only the first n reads, default is 0
    inputBinding:
      position: 101
      prefix: --fixedNumberOfReads
  - id: hash_load_factor
    type:
      - 'null'
      - float
    doc: Load factor of hashtables. 0.0 < hashloadfactor < 1.0. Smaller values 
      can improve the runtime at the expense of greater memory usage, default is
      0.8
    inputBinding:
      position: 101
      prefix: --hashloadfactor
  - id: hashmaps
    type:
      - 'null'
      - int
    doc: The requested number of hash maps. Must be greater than 0. The actual 
      number of used hash maps may be lower to respect the set memory limit, 
      default is 48
    inputBinding:
      position: 101
      prefix: --hashmaps
  - id: input_file1
    type:
      - 'null'
      - string
    doc: input fastq name 1
    inputBinding:
      position: 101
      prefix: --inFile1
  - id: input_file2
    type:
      - 'null'
      - string
    doc: input fastq name 2
    inputBinding:
      position: 101
      prefix: --inFile2
  - id: interleaved_in
    type:
      - 'null'
      - boolean
    doc: use interleaved input (only for pe data), default is off
    inputBinding:
      position: 101
      prefix: --interleavedIn
  - id: interleaved_out
    type:
      - 'null'
      - boolean
    doc: use interleaved output (only for pe data), default is off
    inputBinding:
      position: 101
      prefix: --interleavedOut
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: The kmer length for minhashing. If 0 or missing, it is automatically 
      determined, default is 0
    inputBinding:
      position: 101
      prefix: --kmerlength
  - id: load_hashtables_from
    type:
      - 'null'
      - File
    doc: Load binary dump of hash tables from disk
    inputBinding:
      position: 101
      prefix: --load-hashtables-from
  - id: load_preprocessedreads_from
    type:
      - 'null'
      - File
    doc: Load binary dump of read data structure from disk
    inputBinding:
      position: 101
      prefix: --load-preprocessedreads-from
  - id: max_mismatch_ratio
    type:
      - 'null'
      - float
    doc: Overlap between anchor and candidate must contain at most 
      (maxmismatchratio * overlapsize) mismatches, default is 0.2
    inputBinding:
      position: 101
      prefix: --maxmismatchratio
  - id: mem_hashtables
    type:
      - 'null'
      - string
    doc: Memory limit in bytes for hash tables and hash table construction. Can 
      use suffix K,M,G, e.g. 20G means 20 gigabyte. This option is not a hard 
      limit, default is a bit less than memory
    inputBinding:
      position: 101
      prefix: --memHashtables
  - id: mem_total
    type:
      - 'null'
      - string
    doc: Total memory limit in bytes. Can use suffix K,M,G, e.g. 20G means 20 
      gigabyte. This option is not a hard limit, default is all free memory
    inputBinding:
      position: 101
      prefix: --memTotal
  - id: min_alignment_overlap
    type:
      - 'null'
      - int
    doc: Overlap between anchor and candidate must be at least this long, 
      default is 30
    inputBinding:
      position: 101
      prefix: --minalignmentoverlap
  - id: min_alignment_overlap_ratio
    type:
      - 'null'
      - float
    doc: Overlap between anchor and candidate must be at least as long as 
      (minalignmentoverlapratio * candidatelength), default is 0.3
    inputBinding:
      position: 101
      prefix: --minalignmentoverlapratio
  - id: no_insert_size
    type:
      - 'null'
      - boolean
    doc: no insert size analysis (only for pe data), default is to do insert 
      size analysis
    inputBinding:
      position: 101
      prefix: --noInsertSize
  - id: no_trim_adapter
    type:
      - 'null'
      - boolean
    doc: don't trim adapter, default is off
    inputBinding:
      position: 101
      prefix: --noTrimAdapter
  - id: not_keep_order
    type:
      - 'null'
      - boolean
    doc: do not keep order as input when outputting reads (may slightly improve 
      performance if opened), default is off
    inputBinding:
      position: 101
      prefix: --notKeepOrder
  - id: over_write
    type:
      - 'null'
      - boolean
    doc: overwrite out file if already exists.
    inputBinding:
      position: 101
      prefix: --overWrite
  - id: overrepresentation_sampling
    type:
      - 'null'
      - int
    doc: do overrepresentation every [] reads, default is 20
    inputBinding:
      position: 101
      prefix: --overrepresentationSampling
  - id: pair_mode
    type:
      - 'null'
      - string
    doc: SE (single-end) or PE (paired-end), default is SE
    inputBinding:
      position: 101
      prefix: --pairmode
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: input is using phred64 scoring, default is phred33
    inputBinding:
      position: 101
      prefix: --phred64
  - id: pigz_thread
    type:
      - 'null'
      - int
    doc: 'pigz thread number for each output file, automatic assignment according
      to the number of total threads (-w) by default. Note: must >=2 threads when
      specified manually'
    inputBinding:
      position: 101
      prefix: --pigzThread
  - id: print_orp_seqs
    type:
      - 'null'
      - boolean
    doc: if print overrepresentation sequences to *ORP_sequences.txt or not, 
      default is not
    inputBinding:
      position: 101
      prefix: --printORPSeqs
  - id: print_what_trimmed
    type:
      - 'null'
      - boolean
    doc: if print what trimmed to *_trimmed_adapters.txt or not, default is not
    inputBinding:
      position: 101
      prefix: --printWhatTrimmed
  - id: pugz_thread
    type:
      - 'null'
      - int
    doc: 'pugz thread number for each input file, automatic assignment according to
      the number of total threads (-w) by default. Note: must >=2 threads when specified
      manually'
    inputBinding:
      position: 101
      prefix: --pugzThread
  - id: quality_score_bits
    type:
      - 'null'
      - int
    doc: 'How many bits should be used to store a single quality score. Allowed values:
      1,2,8. If not 8, a lossy compression via binning is used, default is 8'
    inputBinding:
      position: 101
      prefix: --qualityScoreBits
  - id: save_hashtables_to
    type:
      - 'null'
      - File
    doc: Save binary dump of hash tables to disk
    inputBinding:
      position: 101
      prefix: --save-hashtables-to
  - id: save_preprocessedreads_to
    type:
      - 'null'
      - File
    doc: Save binary dump of data structure which stores input reads to disk
    inputBinding:
      position: 101
      prefix: --save-preprocessedreads-to
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: If set, progress bar is shown during correction, default is off
    inputBinding:
      position: 101
      prefix: --showProgress
  - id: single_hash
    type:
      - 'null'
      - boolean
    doc: Use 1 hashtables with h smallest unique hashes, default is off
    inputBinding:
      position: 101
      prefix: --singlehash
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: input from stdin, or -i /dev/stdin, only for se data or interleaved pe 
      data(which means use --interleavedIn)
    inputBinding:
      position: 101
      prefix: --stdin
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: output to stdout, or -o /dev/stdout, only for se data or interleaved pe
      data(which means use --interleavedOut)
    inputBinding:
      position: 101
      prefix: --stdout
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary files, default is the output directory
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: tgs
    type:
      - 'null'
      - boolean
    doc: process third generation sequencing (TGS) data (only for se data, does 
      not support trimming and will not produce output files), default is off
    inputBinding:
      position: 101
      prefix: --TGS
  - id: thread_num
    type:
      - 'null'
      - int
    doc: number of thread used to do QC, including (de)compression for 
      compressed data, default is 8
    inputBinding:
      position: 101
      prefix: --threadNum
  - id: trim3_end
    type:
      - 'null'
      - boolean
    doc: do sliding window from 5end to 3end to trim low quality bases, default 
      is off
    inputBinding:
      position: 101
      prefix: --trim3End
  - id: trim5_end
    type:
      - 'null'
      - boolean
    doc: do sliding window from 5end to 3end to trim low quality bases, default 
      is off
    inputBinding:
      position: 101
      prefix: --trim5End
  - id: trim_front1
    type:
      - 'null'
      - int
    doc: number of bases to trim from front in read1, default is 0
    inputBinding:
      position: 101
      prefix: --trimFront1
  - id: trim_front2
    type:
      - 'null'
      - int
    doc: number of bases to trim from front in read2, default is 0
    inputBinding:
      position: 101
      prefix: --trimFront2
  - id: trim_polyg
    type:
      - 'null'
      - boolean
    doc: do polyg tail trim, default is off
    inputBinding:
      position: 101
      prefix: --trimPolyg
  - id: trim_polyx
    type:
      - 'null'
      - boolean
    doc: do polyx tail trim, default is off
    inputBinding:
      position: 101
      prefix: --trimPolyx
  - id: trim_tail1
    type:
      - 'null'
      - int
    doc: number of bases to trim from tail in read1, default is 0
    inputBinding:
      position: 101
      prefix: --trimTail1
  - id: trim_tail2
    type:
      - 'null'
      - int
    doc: number of bases to trim from tail in read2, default is 0
    inputBinding:
      position: 101
      prefix: --trimTail2
  - id: umi_len
    type:
      - 'null'
      - int
    doc: umi length if it is in read1/read2, default is 0
    inputBinding:
      position: 101
      prefix: --umiLen
  - id: umi_loc
    type:
      - 'null'
      - string
    doc: specify the location of umi, can be 
      (index1/index2/read1/read2/per_index/per_read), default is 0
    inputBinding:
      position: 101
      prefix: --umiLoc
  - id: umi_prefix
    type:
      - 'null'
      - string
    doc: identification to be added in front of umi, default is no prefix
    inputBinding:
      position: 101
      prefix: --umiPrefix
  - id: umi_skip
    type:
      - 'null'
      - int
    doc: the number bases to skip if umi exists, default is 0
    inputBinding:
      position: 101
      prefix: --umiSkip
  - id: use_igzip
    type:
      - 'null'
      - boolean
    doc: use igzip instead of pugz/zlib, default is off
    inputBinding:
      position: 101
      prefix: --useIgzip
  - id: use_quality_scores
    type:
      - 'null'
      - boolean
    doc: If set, quality scores (if any) are considered during read correction, 
      default is off
    inputBinding:
      position: 101
      prefix: --useQualityScores
outputs:
  - id: output_file1
    type:
      - 'null'
      - File
    doc: output fastq name 1
    outputBinding:
      glob: $(inputs.output_file1)
  - id: output_file2
    type:
      - 'null'
      - File
    doc: output fastq name 2
    outputBinding:
      glob: $(inputs.output_file2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbitqcplus:2.3.0--h5ca1c30_1
