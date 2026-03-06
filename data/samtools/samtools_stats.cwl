cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - stats
label: samtools_stats
doc: The program collects statistics from BAM files. The output can be 
  visualized using plot-bamstats.
inputs:
  - id: input_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - string
    doc: Region in format chr:from-to
    inputBinding:
      position: 2
  - id: cov_threshold
    type:
      - 'null'
      - int
    doc: Only bases with coverage above this value will be included in the 
      target percentage computation
    inputBinding:
      position: 103
      prefix: --cov-threshold
  - id: coverage
    type:
      - 'null'
      - string
    doc: Coverage distribution min,max,step
    inputBinding:
      position: 103
      prefix: --coverage
  - id: customized_index_file
    type:
      - 'null'
      - boolean
    doc: Use a customized index file
    inputBinding:
      position: 103
      prefix: --customized-index-file
  - id: filtering_flag
    type:
      - 'null'
      - string
    doc: Filtering flag, 0 for unset. See also `samtools flags`
    inputBinding:
      position: 103
      prefix: --filtering-flag
  - id: gc_depth
    type:
      - 'null'
      - float
    doc: the size of GC-depth bins (decreasing bin size increases memory 
      requirement)
    inputBinding:
      position: 103
      prefix: --GC-depth
  - id: id
    type:
      - 'null'
      - string
    doc: Include only listed read group or sample name
    inputBinding:
      position: 103
      prefix: --id
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
  - id: insert_size
    type:
      - 'null'
      - int
    doc: Maximum insert size
    inputBinding:
      position: 103
      prefix: --insert-size
  - id: most_inserts
    type:
      - 'null'
      - float
    doc: Report only the main part of inserts
    inputBinding:
      position: 103
      prefix: --most-inserts
  - id: read_length
    type:
      - 'null'
      - int
    doc: Include in the statistics only reads with the given read length
    inputBinding:
      position: 103
      prefix: --read-length
  - id: ref_seq
    type: File?
    doc: Reference sequence (required for GC-depth and mismatches-per-cycle 
      calculation).
    inputBinding:
      position: 103
      prefix: --ref-seq
  - id: ref_stats
    type:
      - 'null'
      - boolean
    doc: Create statistics on reference data.
    inputBinding:
      position: 103
      prefix: --ref-stats
  - id: ref_stats_chunk
    type:
      - 'null'
      - int
    doc: Reference retrival chunk size, in Mbs, for reference statistics
    inputBinding:
      position: 103
      prefix: --ref-stats-chunk
  - id: reference
    type: File?
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 103
      prefix: --reference
  - id: remove_dups
    type:
      - 'null'
      - boolean
    doc: Exclude from statistics reads marked as duplicates
    inputBinding:
      position: 103
      prefix: --remove-dups
  - id: remove_overlaps
    type:
      - 'null'
      - boolean
    doc: Remove overlaps of paired-end reads from coverage and base count 
      computations.
    inputBinding:
      position: 103
      prefix: --remove-overlaps
  - id: required_flag
    type: string?
    doc: Required flag, 0 for unset. See also `samtools flags`
    inputBinding:
      position: 103
      prefix: --required-flag
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Ignored (input format is auto-detected).
    inputBinding:
      position: 103
      prefix: --sam
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: Suppress outputting IS rows where there are no insertions.
    inputBinding:
      position: 103
      prefix: --sparse
  - id: split
    type:
      - 'null'
      - string
    doc: Also write statistics to separate files split by tagged field.
    inputBinding:
      position: 103
      prefix: --split
  - id: split_prefix
    type:
      - 'null'
      - string
    doc: Path or string prefix for filepaths output by -S (default is input 
      filename)
    inputBinding:
      position: 103
      prefix: --split-prefix
  - id: target_regions
    type: File?
    doc: Do stats in these regions only. Tab-delimited file chr,from,to, 
      1-based, inclusive.
    inputBinding:
      position: 103
      prefix: --target-regions
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: trim_quality
    type:
      - 'null'
      - int
    doc: The BWA trimming parameter
    inputBinding:
      position: 103
      prefix: --trim-quality
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_stats.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
