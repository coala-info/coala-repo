cwlVersion: v1.2
class: CommandLineTool
baseCommand: perm
label: perm
doc: "PerM (Periodic Seed Mapping) is a fast mapping program for short reads (e.g.,
  Illumina, SOLiD) to a reference genome, using periodic seeds to improve sensitivity.\n\nTool
  homepage: https://code.google.com/archive/p/perm/"
inputs:
  - id: reference
    type: File
    doc: Reference FASTA file (*.fa, *.fasta), a text file listing reference paths, or a saved index
    inputBinding:
      position: 1
  - id: reads
    type:
      - 'null'
      - File
    doc: Reads file (.fasta, .fastq or .csfasta) for single-end mapping, or a text file listing read files
    inputBinding:
      position: 2
  - id: reads_1
    type:
      - 'null'
      - File
    doc: Forward reads for mate-paired mapping
    inputBinding:
      position: 103
      prefix: '-1'
  - id: reads_2
    type:
      - 'null'
      - File
    doc: Reverse reads for mate-paired mapping
    inputBinding:
      position: 103
      prefix: '-2'
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: Output all alignments within the mismatch threshold (see -v), end-to-end
    inputBinding:
      position: 103
      prefix: -A
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: Output only uniquely mapped reads remaining after the best down selection; with -A, only the uniquely mapped reads
    inputBinding:
      position: 103
      prefix: -E
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed (or allowed in each end for pair-end reads)
    inputBinding:
      position: 103
      prefix: -v
  - id: skip_5prime
    type:
      - 'null'
      - int
    doc: Number of bases at the 5' end of each read to ignore
    inputBinding:
      position: 103
      prefix: -t
  - id: use_bases
    type:
      - 'null'
      - int
    doc: Number of bases in each read to use, starting after any bases ignored by -t
    inputBinding:
      position: 103
      prefix: -T
  - id: max_mappings
    type:
      - 'null'
      - int
    doc: The maximum number of mappings per read (default 200, maximum 2000)
    inputBinding:
      position: 103
      prefix: -k
  - id: rebuild_index
    type:
      - 'null'
      - boolean
    doc: Create the reference index without reusing the saved index even if available
    inputBinding:
      position: 103
      prefix: -m
  - id: save_index_path
    type:
      - 'null'
      - string
    doc: Save the reference index to accelerate the mapping in the future
    inputBinding:
      position: 103
      prefix: -s
  - id: output_path
    type:
      - 'null'
      - string
    doc: Name of the mapping output file when mapping a single read set (.sam or .mapping); for paired reads the path or directory
    inputBinding:
      position: 103
      prefix: -o
  - id: output_dir_path
    type:
      - 'null'
      - string
    doc: Output directory for mapping output files when mapping multiple read sets
    inputBinding:
      position: 103
      prefix: -d
  - id: multimapped_reads_path
    type:
      - 'null'
      - string
    doc: Create a FASTA (FASTQ) file for reads mapped to more positions than the -k threshold
    inputBinding:
      position: 103
      prefix: -a
  - id: bad_reads_path
    type:
      - 'null'
      - string
    doc: Create a FASTA (FASTQ) file of bad reads or reads shorter than expected
    inputBinding:
      position: 103
      prefix: -b
  - id: unmapped_reads_path
    type:
      - 'null'
      - string
    doc: Create a FASTA (FASTQ) file of unmapped reads
    inputBinding:
      position: 103
      prefix: -u
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output the mapping count to a specified file
    inputBinding:
      position: 103
      prefix: --log
  - id: forward_only
    type:
      - 'null'
      - boolean
    doc: Map reads to the forward strand only (SOLiD strand specific sequencing)
    inputBinding:
      position: 103
      prefix: --forwardOnly
  - id: reverse_only
    type:
      - 'null'
      - boolean
    doc: Map reads to the reverse strand only (SOLiD strand specific sequencing)
    inputBinding:
      position: 103
      prefix: --reverseOnly
  - id: ambiguous_read_only
    type:
      - 'null'
      - boolean
    doc: Output only ambiguous mapping to find repeats
    inputBinding:
      position: 103
      prefix: --ambiguosReadOnly
  - id: ambiguous_read_in_one_line
    type:
      - 'null'
      - boolean
    doc: Output reads mapped to more than k places in one line
    inputBinding:
      position: 103
      prefix: --ambiguosReadInOneLine
  - id: no_sam_header
    type:
      - 'null'
      - boolean
    doc: Do not print the SAM header
    inputBinding:
      position: 103
      prefix: --noSamHeader
  - id: includes_reads_with_n
    type:
      - 'null'
      - int
    doc: Map reads with at most this number of N or '.' bases by encoding them as A or 3
    inputBinding:
      position: 103
      prefix: --includeReadsWN
  - id: stats_only
    type:
      - 'null'
      - boolean
    doc: Output the mapping statistics to stdout only, without saving alignments to files
    inputBinding:
      position: 103
      prefix: --statsOnly
  - id: ignore_qs
    type:
      - 'null'
      - boolean
    doc: Ignore the quality scores in fastq or QUAL files
    inputBinding:
      position: 103
      prefix: --ignoreQS
  - id: print_nm
    type:
      - 'null'
      - boolean
    doc: When quality scores are available, print number of mismatches instead of mismatch scores in mapping format
    inputBinding:
      position: 103
      prefix: --printNM
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter character of the read id, for unusual read file formats
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: seed
    type:
      - 'null'
      - string
    doc: Seed pattern - F0, F1, F2, F3, F4, S11 or S12
    inputBinding:
      position: 103
      prefix: --seed
  - id: ref_format
    type:
      - 'null'
      - string
    doc: Reference format - fasta, list or index (instead of guessing from the extension)
    inputBinding:
      position: 103
      prefix: --refFormat
  - id: read_format
    type:
      - 'null'
      - string
    doc: Read format - fasta, fastq, csfasta or csfastq (instead of guessing from the extension)
    inputBinding:
      position: 103
      prefix: --readFormat
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format - sam, mapping or fastq (instead of guessing from the extension)
    inputBinding:
      position: 103
      prefix: --outputFormat
  - id: min_pair_distance
    type:
      - 'null'
      - int
    doc: Lower bound for mate-paired separation distance
    inputBinding:
      position: 103
      prefix: -L
  - id: max_pair_distance
    type:
      - 'null'
      - int
    doc: Upper bound for mate-paired separation distance
    inputBinding:
      position: 103
      prefix: -U
  - id: exclude_ambiguous_pairs
    type:
      - 'null'
      - boolean
    doc: Exclude ambiguous paired mappings
    inputBinding:
      position: 103
      prefix: -e
  - id: fr
    type:
      - 'null'
      - boolean
    doc: Map paired-end reads to different strand only
    inputBinding:
      position: 103
      prefix: --fr
  - id: ff
    type:
      - 'null'
      - boolean
    doc: Map paired-end reads to the same strand only
    inputBinding:
      position: 103
      prefix: --ff
  - id: print_ref_seq
    type:
      - 'null'
      - boolean
    doc: Print the reference sequence of paired-end mapping in .mapping format
    inputBinding:
      position: 103
      prefix: --printRefSeq
  - id: print_qual
    type:
      - 'null'
      - boolean
    doc: Print the read quality scores for paired-end mapping in .mapping format
    inputBinding:
      position: 103
      prefix: --printQual
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with mapping messages
  - id: output_file
    type:
      - 'null'
      - File
    doc: Mapping output file written with -o
    outputBinding:
      glob: $(inputs.output_path)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory written with -d
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: index_file
    type:
      - 'null'
      - File
    doc: Reference index saved with -s
    outputBinding:
      glob: $(inputs.save_index_path)
  - id: multimapped_reads
    type:
      - 'null'
      - File
    doc: Reads mapped to more positions than the -k threshold
    outputBinding:
      glob: $(inputs.multimapped_reads_path)
  - id: bad_reads
    type:
      - 'null'
      - File
    doc: Bad or too short reads
    outputBinding:
      glob: $(inputs.bad_reads_path)
  - id: unmapped_reads
    type:
      - 'null'
      - File
    doc: Unmapped reads
    outputBinding:
      glob: $(inputs.unmapped_reads_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Mapping count log
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perm:v0.4.0-4-deb_cv1
stdout: perm.out
