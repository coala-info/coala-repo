cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalt_map
label: smalt_map
doc: "Map reads to an index\n\nTool homepage: https://github.com/roquie/smalte"
inputs:
  - id: index_name
    type: string
    doc: Name of the index to map to
    inputBinding:
      position: 1
  - id: query_file
    type: File
    doc: Query file containing reads
    inputBinding:
      position: 2
  - id: mate_file
    type:
      - 'null'
      - File
    doc: Optional mate file for paired-end reads
    inputBinding:
      position: 3
  - id: add_explicit_alignments
    type:
      - 'null'
      - boolean
    doc: Add explicit alignments to output.
    inputBinding:
      position: 104
      prefix: -a
  - id: alignment_penalties
    type:
      - 'null'
      - string
    doc: Set alignment penalties, e.g 'match=1,mismatch=-2,gapopen=-4,gapext=-3'
      (default).
    inputBinding:
      position: 104
      prefix: -S
  - id: alignment_score_threshold
    type:
      - 'null'
      - int
    doc: Threshold of alignment score.
    inputBinding:
      position: 104
      prefix: -m
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: Base quality threshold <= 10 (default 0).
    default: 0
    inputBinding:
      position: 104
      prefix: -q
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: Exhaustive search for alignments (at the cost of speed).
    inputBinding:
      position: 104
      prefix: -x
  - id: extensive_help
    type:
      - 'null'
      - boolean
    doc: Print more extensive help on options.
    inputBinding:
      position: 104
      prefix: -H
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: 'Identity threshold (default: 0).'
    default: 0.0
    inputBinding:
      position: 104
      prefix: -y
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format [fastq (default)|sam|bam].
    default: fastq
    inputBinding:
      position: 104
      prefix: -F
  - id: insert_size_distribution_file
    type:
      - 'null'
      - File
    doc: Reads insert size distribution from file (see 'sample' task).
    inputBinding:
      position: 104
      prefix: -g
  - id: kmer_seed_coverage_threshold
    type:
      - 'null'
      - int
    doc: Threshold of the number of bases covered by k-mer seeds.
    inputBinding:
      position: 104
      prefix: -c
  - id: max_insert_size_paired_reads
    type:
      - 'null'
      - int
    doc: 'Maximum insert size for paired reads (default: 500).'
    default: 500
    inputBinding:
      position: 104
      prefix: -i
  - id: min_insert_size_paired_reads
    type:
      - 'null'
      - int
    doc: 'Minimum insert size for paired reads (default: 0).'
    default: 0
    inputBinding:
      position: 104
      prefix: -j
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format [sam(default)|bam|cigar|gff|ssaha]. Ext: [sam|bam]:nohead,x,clip.'
    default: sam
    inputBinding:
      position: 104
      prefix: -f
  - id: paired_read_library_type
    type:
      - 'null'
      - string
    doc: 'Type of paired read library [pe|mp|pp] (default: pe).'
    default: pe
    inputBinding:
      position: 104
      prefix: -l
  - id: preserve_read_order
    type:
      - 'null'
      - boolean
    doc: Preserve the order of the reads in the output (with '-n').
    inputBinding:
      position: 104
      prefix: -O
  - id: random_assignment_degen_mappings
    type:
      - 'null'
      - int
    doc: Random assignment of degen. mappings (mark 'unmapped' if < 0).
    inputBinding:
      position: 104
      prefix: -r
  - id: report_split_alignments
    type:
      - 'null'
      - boolean
    doc: Report split alignments.
    inputBinding:
      position: 104
      prefix: -p
  - id: smith_waterman_score_relative_to_best_threshold
    type:
      - 'null'
      - int
    doc: Threshold of the Smith-Waterman score relative to best.
    inputBinding:
      position: 104
      prefix: -d
  - id: temp_files_directory
    type:
      - 'null'
      - Directory
    doc: Write temporary files do specified directory.
    inputBinding:
      position: 104
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 104
      prefix: -n
  - id: use_complexity_weighted_smith_waterman
    type:
      - 'null'
      - boolean
    doc: Use complexity weighted Smith-Waterman scores.
    inputBinding:
      position: 104
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Write aligments to specified file (default: stdout).'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
