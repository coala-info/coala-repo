cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexbar
label: flexbar
doc: "The program Flexbar preprocesses high-throughput sequencing data efficiently.
  It demultiplexes barcoded runs and removes adapter sequences.\n\nTool homepage:
  https://github.com/seqan/flexbar"
inputs:
  - id: adapter_error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for mismatches and gaps.
    inputBinding:
      position: 101
      prefix: --adapter-error-rate
  - id: adapter_min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap for removal without pair overlap.
    inputBinding:
      position: 101
      prefix: --adapter-min-overlap
  - id: adapter_pair_overlap
    type:
      - 'null'
      - string
    doc: Overlap detection of paired reads. One of ON, SHORT, and ONLY.
    inputBinding:
      position: 101
      prefix: --adapter-pair-overlap
  - id: adapter_preset
    type:
      - 'null'
      - string
    doc: One of TruSeq, SmallRNA, Methyl, Ribo, Nextera, and NexteraMP.
    inputBinding:
      position: 101
      prefix: --adapter-preset
  - id: adapter_trim_end
    type:
      - 'null'
      - string
    doc: Type of removal, see section trim-end modes.
    inputBinding:
      position: 101
      prefix: --adapter-trim-end
  - id: adapters
    type:
      - 'null'
      - File
    doc: Fasta file with adapters for removal that may contain N.
    inputBinding:
      position: 101
      prefix: --adapters
  - id: adapters2
    type:
      - 'null'
      - File
    doc: File with extra adapters for second read set in paired mode.
    inputBinding:
      position: 101
      prefix: --adapters2
  - id: align_log
    type:
      - 'null'
      - string
    doc: Print chosen read alignments. One of ALL, MOD, and TAB.
    inputBinding:
      position: 101
      prefix: --align-log
  - id: barcode_error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for mismatches and gaps.
    inputBinding:
      position: 101
      prefix: --barcode-error-rate
  - id: barcode_min_overlap
    type:
      - 'null'
      - int
    doc: 'Minimum overlap of barcode and read. Default: barcode length.'
    inputBinding:
      position: 101
      prefix: --barcode-min-overlap
  - id: barcode_reads
    type:
      - 'null'
      - File
    doc: Fasta/q file containing separate barcode reads for detection.
    inputBinding:
      position: 101
      prefix: --barcode-reads
  - id: barcode_trim_end
    type:
      - 'null'
      - string
    doc: Type of detection, see section trim-end modes.
    inputBinding:
      position: 101
      prefix: --barcode-trim-end
  - id: barcodes
    type:
      - 'null'
      - File
    doc: Fasta file with barcodes for demultiplexing, may contain N.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Prefer non-quality format fasta for output.
    inputBinding:
      position: 101
      prefix: --fasta-output
  - id: htrim_error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for mismatches.
    inputBinding:
      position: 101
      prefix: --htrim-error-rate
  - id: htrim_min_length
    type:
      - 'null'
      - int
    doc: Minimum length of homopolymers at read ends.
    inputBinding:
      position: 101
      prefix: --htrim-min-length
  - id: htrim_right
    type:
      - 'null'
      - string
    doc: Trim certain homopolymers on right read end after removal.
    inputBinding:
      position: 101
      prefix: --htrim-right
  - id: max_uncalled
    type:
      - 'null'
      - int
    doc: Allowed uncalled bases N for each read.
    inputBinding:
      position: 101
      prefix: --max-uncalled
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length to remain after removal.
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: pre_trim_left
    type:
      - 'null'
      - int
    doc: Trim given number of bases on 5' read end before detection.
    inputBinding:
      position: 101
      prefix: --pre-trim-left
  - id: pre_trim_right
    type:
      - 'null'
      - int
    doc: Trim specified number of bases on 3' end prior to detection.
    inputBinding:
      position: 101
      prefix: --pre-trim-right
  - id: qtrim
    type:
      - 'null'
      - string
    doc: Quality-based trimming mode. One of TAIL, WIN, and BWA.
    inputBinding:
      position: 101
      prefix: --qtrim
  - id: qtrim_format
    type:
      - 'null'
      - string
    doc: Quality format. One of sanger, solexa, i1.3, i1.5, and i1.8.
    inputBinding:
      position: 101
      prefix: --qtrim-format
  - id: qtrim_threshold
    type:
      - 'null'
      - int
    doc: Minimum quality as threshold for trimming.
    inputBinding:
      position: 101
      prefix: --qtrim-threshold
  - id: reads
    type: File
    doc: Fasta/q file or stdin (-) with reads that may contain barcodes.
    inputBinding:
      position: 101
      prefix: --reads
  - id: reads2
    type:
      - 'null'
      - File
    doc: Second input file of paired reads, gz and bz2 files supported.
    inputBinding:
      position: 101
      prefix: --reads2
  - id: removal_tags
    type:
      - 'null'
      - boolean
    doc: Tag reads that are subject to adapter or barcode removal.
    inputBinding:
      position: 101
      prefix: --removal-tags
  - id: stdout_log
    type:
      - 'null'
      - boolean
    doc: Write statistics to stdout instead of target log file.
    inputBinding:
      position: 101
      prefix: --stdout-log
  - id: stdout_reads
    type:
      - 'null'
      - boolean
    doc: Write reads to stdout, tagged and interleaved if needed.
    inputBinding:
      position: 101
      prefix: --stdout-reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to employ.
    inputBinding:
      position: 101
      prefix: --threads
  - id: zip_output
    type:
      - 'null'
      - string
    doc: Direct compression of output files. One of GZ and BZ2.
    inputBinding:
      position: 101
      prefix: --zip-output
  - id: bundle
    type:
      - 'null'
      - int
    doc: 'Number of (paired) reads per thread. Default: 256.'
    inputBinding:
      position: 101
      prefix: --bundle
  - id: bundles
    type:
      - 'null'
      - int
    doc: Process only certain number of bundles for testing.
    inputBinding:
      position: 101
      prefix: --bundles
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved format for first input set with paired reads.
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: iupac
    type:
      - 'null'
      - boolean
    doc: Accept iupac symbols in reads and convert to N if not ATCG.
    inputBinding:
      position: 101
      prefix: --iupac
  - id: barcodes2
    type:
      - 'null'
      - File
    doc: Additional barcodes file for second read set in paired mode.
    inputBinding:
      position: 101
      prefix: --barcodes2
  - id: barcode_tail_length
    type:
      - 'null'
      - int
    doc: 'Region size in tail trim-end modes. Default: barcode length.'
    inputBinding:
      position: 101
      prefix: --barcode-tail-length
  - id: barcode_keep
    type:
      - 'null'
      - boolean
    doc: Keep barcodes within reads instead of removal.
    inputBinding:
      position: 101
      prefix: --barcode-keep
  - id: barcode_unassigned
    type:
      - 'null'
      - boolean
    doc: Include unassigned reads in output generation.
    inputBinding:
      position: 101
      prefix: --barcode-unassigned
  - id: barcode_match
    type:
      - 'null'
      - int
    doc: 'Alignment match score. Default: 1.'
    inputBinding:
      position: 101
      prefix: --barcode-match
  - id: barcode_mismatch
    type:
      - 'null'
      - int
    doc: 'Alignment mismatch score. Default: -1.'
    inputBinding:
      position: 101
      prefix: --barcode-mismatch
  - id: barcode_gap
    type:
      - 'null'
      - int
    doc: 'Alignment gap score. Default: -9.'
    inputBinding:
      position: 101
      prefix: --barcode-gap
  - id: adapter_seq
    type:
      - 'null'
      - string
    doc: Single adapter sequence as alternative to adapters option.
    inputBinding:
      position: 101
      prefix: --adapter-seq
  - id: adapter_tail_length
    type:
      - 'null'
      - int
    doc: 'Region size for tail trim-end modes. Default: adapter length.'
    inputBinding:
      position: 101
      prefix: --adapter-tail-length
  - id: adapter_relaxed
    type:
      - 'null'
      - boolean
    doc: Skip restriction to pass read ends in right and left modes.
    inputBinding:
      position: 101
      prefix: --adapter-relaxed
  - id: adapter_min_poverlap
    type:
      - 'null'
      - int
    doc: 'Minimum overlap of paired reads for detection. Default: 40.'
    inputBinding:
      position: 101
      prefix: --adapter-min-poverlap
  - id: adapter_revcomp
    type:
      - 'null'
      - string
    doc: Include reverse complements of adapters. One of ON and ONLY.
    inputBinding:
      position: 101
      prefix: --adapter-revcomp
  - id: adapter_revcomp_end
    type:
      - 'null'
      - string
    doc: Use different trim-end for reverse complements of adapters.
    inputBinding:
      position: 101
      prefix: --adapter-revcomp-end
  - id: adapter_add_barcode
    type:
      - 'null'
      - boolean
    doc: Add reverse complement of detected barcode to adapters.
    inputBinding:
      position: 101
      prefix: --adapter-add-barcode
  - id: adapter_read_set
    type:
      - 'null'
      - string
    doc: Consider only single read set for adapters. One of 1 and 2.
    inputBinding:
      position: 101
      prefix: --adapter-read-set
  - id: adapter_trimmed_out
    type:
      - 'null'
      - string
    doc: Modify that trimmed reads are kept. One of OFF and ONLY.
    inputBinding:
      position: 101
      prefix: --adapter-trimmed-out
  - id: adapter_cycles
    type:
      - 'null'
      - int
    doc: 'Number of adapter removal cycles. Default: 1.'
    inputBinding:
      position: 101
      prefix: --adapter-cycles
  - id: adapter_match
    type:
      - 'null'
      - int
    doc: 'Alignment match score. Default: 1.'
    inputBinding:
      position: 101
      prefix: --adapter-match
  - id: adapter_mismatch
    type:
      - 'null'
      - int
    doc: 'Alignment mismatch score. Default: -1.'
    inputBinding:
      position: 101
      prefix: --adapter-mismatch
  - id: adapter_gap
    type:
      - 'null'
      - int
    doc: 'Alignment gap score. Default: -6.'
    inputBinding:
      position: 101
      prefix: --adapter-gap
  - id: post_trim_length
    type:
      - 'null'
      - int
    doc: Trim to specified read length from 3' end after removal.
    inputBinding:
      position: 101
      prefix: --post-trim-length
  - id: qtrim_win_size
    type:
      - 'null'
      - int
    doc: 'Region size for sliding window approach. Default: 5.'
    inputBinding:
      position: 101
      prefix: --qtrim-win-size
  - id: qtrim_post_removal
    type:
      - 'null'
      - boolean
    doc: Perform quality-based trimming after removal steps.
    inputBinding:
      position: 101
      prefix: --qtrim-post-removal
  - id: htrim_left
    type:
      - 'null'
      - string
    doc: Trim specific homopolymers on left read end after removal.
    inputBinding:
      position: 101
      prefix: --htrim-left
  - id: htrim_min_length2
    type:
      - 'null'
      - int
    doc: Minimum length for homopolymers specified after first one.
    inputBinding:
      position: 101
      prefix: --htrim-min-length2
  - id: htrim_max_length
    type:
      - 'null'
      - int
    doc: Maximum length of homopolymers on left and right read end.
    inputBinding:
      position: 101
      prefix: --htrim-max-length
  - id: htrim_max_first
    type:
      - 'null'
      - boolean
    doc: Apply maximum length of homopolymers only for first one.
    inputBinding:
      position: 101
      prefix: --htrim-max-first
  - id: htrim_adapter
    type:
      - 'null'
      - boolean
    doc: Trim only in case of adapter removal on same side.
    inputBinding:
      position: 101
      prefix: --htrim-adapter
  - id: output_reads
    type:
      - 'null'
      - string
    doc: Output file for reads instead of target prefix usage.
    inputBinding:
      position: 101
      prefix: --output-reads
  - id: output_reads2
    type:
      - 'null'
      - string
    doc: Output file for reads2 instead of target prefix usage.
    inputBinding:
      position: 101
      prefix: --output-reads2
  - id: length_dist
    type:
      - 'null'
      - boolean
    doc: Generate length distribution for read output files.
    inputBinding:
      position: 101
      prefix: --length-dist
  - id: single_reads
    type:
      - 'null'
      - boolean
    doc: Write single reads for too short counterparts in pairs.
    inputBinding:
      position: 101
      prefix: --single-reads
  - id: single_reads_paired
    type:
      - 'null'
      - boolean
    doc: Write paired single reads with N for short counterparts.
    inputBinding:
      position: 101
      prefix: --single-reads-paired
  - id: output_log
    type:
      - 'null'
      - string
    doc: Output file for logging instead of target prefix usage.
    inputBinding:
      position: 101
      prefix: --output-log
  - id: number_tags
    type:
      - 'null'
      - boolean
    doc: Replace read tags by ascending number to save space.
    inputBinding:
      position: 101
      prefix: --number-tags
  - id: umi_tags
    type:
      - 'null'
      - boolean
    doc: Capture UMIs in reads at barcode or adapter N positions.
    inputBinding:
      position: 101
      prefix: --umi-tags
  - id: target_path
    type: string
    inputBinding:
      position: 102
      prefix: --target
outputs:
  - id: target
    type:
      - 'null'
      - type: array
        items: File
    doc: Prefix for output file names or paths.
    outputBinding:
      glob: $(inputs.target_path)*
  - id: output_reads_file
    type:
      - 'null'
      - File
    doc: Reads written with --output-reads
    outputBinding:
      glob: $(inputs.output_reads)
  - id: output_reads2_file
    type:
      - 'null'
      - File
    doc: Reads written with --output-reads2
    outputBinding:
      glob: $(inputs.output_reads2)
  - id: output_log_file
    type:
      - 'null'
      - File
    doc: Log written with --output-log
    outputBinding:
      glob: $(inputs.output_log)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexbar:3.5.0--hdfd68b8_12
