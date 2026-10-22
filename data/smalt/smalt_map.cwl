cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smalt
  - map
label: smalt_map
doc: "Map reads to an index\n\nTool homepage: https://www.sanger.ac.uk/tool/smalt-0/"
inputs:
  - id: index_name
    type: string
    doc: Name of the index to map to
    inputBinding:
      position: 102
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files (<index_name>.sma and <index_name>.smi) made by smalt index. 
      They are staged in the working directory so that index_name resolves.
  - id: query_file
    type: File
    doc: Query file containing reads
    inputBinding:
      position: 103
  - id: mate_file
    type:
      - 'null'
      - File
    doc: Optional mate file for paired-end reads
    inputBinding:
      position: 104
  - id: add_explicit_alignments
    type:
      - 'null'
      - boolean
    doc: Add explicit alignments to output.
    inputBinding:
      position: 101
      prefix: -a
  - id: alignment_penalties
    type:
      - 'null'
      - string
    doc: Set alignment penalties, e.g 'match=1,mismatch=-2,gapopen=-4,gapext=-3'
      (default).
    inputBinding:
      position: 101
      prefix: -S
  - id: alignment_score_threshold
    type:
      - 'null'
      - int
    doc: Threshold of alignment score.
    inputBinding:
      position: 101
      prefix: -m
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: Base quality threshold <= 10 (default 0).
    inputBinding:
      position: 101
      prefix: -q
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: Exhaustive search for alignments (at the cost of speed).
    inputBinding:
      position: 101
      prefix: -x
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: 'Identity threshold (default: 0).'
    inputBinding:
      position: 101
      prefix: -y
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format [fastq (default)|sam|bam].
    inputBinding:
      position: 101
      prefix: -F
  - id: insert_size_distribution_file
    type:
      - 'null'
      - File
    doc: Reads insert size distribution from file (see 'sample' task).
    inputBinding:
      position: 101
      prefix: -g
  - id: kmer_seed_coverage_threshold
    type:
      - 'null'
      - int
    doc: Threshold of the number of bases covered by k-mer seeds.
    inputBinding:
      position: 101
      prefix: -c
  - id: max_insert_size_paired_reads
    type:
      - 'null'
      - int
    doc: 'Maximum insert size for paired reads (default: 500).'
    inputBinding:
      position: 101
      prefix: -i
  - id: min_insert_size_paired_reads
    type:
      - 'null'
      - int
    doc: 'Minimum insert size for paired reads (default: 0).'
    inputBinding:
      position: 101
      prefix: -j
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format [sam(default)|bam|cigar|gff|ssaha]. Ext: [sam|bam]:nohead,x,clip.'
    inputBinding:
      position: 101
      prefix: -f
  - id: paired_read_library_type
    type:
      - 'null'
      - string
    doc: 'Type of paired read library [pe|mp|pp] (default: pe).'
    inputBinding:
      position: 101
      prefix: -l
  - id: preserve_read_order
    type:
      - 'null'
      - boolean
    doc: Preserve the order of the reads in the output (with '-n').
    inputBinding:
      position: 101
      prefix: -O
  - id: random_assignment_degen_mappings
    type:
      - 'null'
      - int
    doc: Random assignment of degen. mappings (mark 'unmapped' if < 0).
    inputBinding:
      position: 101
      prefix: -r
  - id: report_split_alignments
    type:
      - 'null'
      - boolean
    doc: Report split alignments.
    inputBinding:
      position: 101
      prefix: -p
  - id: smith_waterman_score_relative_to_best_threshold
    type:
      - 'null'
      - int
    doc: Threshold of the Smith-Waterman score relative to best.
    inputBinding:
      position: 101
      prefix: -d
  - id: temp_files_directory
    type:
      - 'null'
      - string
    doc: Write temporary files do specified directory.
    inputBinding:
      position: 101
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: -n
  - id: use_complexity_weighted_smith_waterman
    type:
      - 'null'
      - boolean
    doc: Use complexity weighted Smith-Waterman scores.
    inputBinding:
      position: 101
      prefix: -w
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Write aligments to specified file (default: stdout).'
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
