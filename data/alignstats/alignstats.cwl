cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignstats
label: alignstats
doc: "AlignStats reports various metrics for SAM, BAM, or CRAM files, including alignment
  statistics and coverage information.\n\nTool homepage: https://github.com/jfarek/alignstats"
inputs:
  - id: coverage_mask
    type:
      - 'null'
      - File
    doc: File in BED format listing regions of N bases in reference. Coverage counts
      will be suppressed for these regions.
    inputBinding:
      position: 101
      prefix: -m
  - id: decompression_threads
    type:
      - 'null'
      - int
    doc: Number of HTSlib decompression threads to spawn.
    inputBinding:
      position: 101
      prefix: -P
  - id: disable_alignment_stats
    type:
      - 'null'
      - boolean
    doc: Disable reporting alignment statistics.
    inputBinding:
      position: 101
      prefix: -A
  - id: disable_capture_coverage
    type:
      - 'null'
      - boolean
    doc: Disable reporting capture coverage statistics.
    inputBinding:
      position: 101
      prefix: -C
  - id: disable_exclude_duplicates
    type:
      - 'null'
      - boolean
    doc: Disable excluding duplicate reads from coverage statistics.
    inputBinding:
      position: 101
      prefix: -D
  - id: disable_genome_coverage
    type:
      - 'null'
      - boolean
    doc: Disable reporting whole genome coverage statistics.
    inputBinding:
      position: 101
      prefix: -W
  - id: disable_unplaced_unmapped
    type:
      - 'null'
      - boolean
    doc: Disable processing unplaced unmapped reads (CHROM "*") when using the -r
      option.
    inputBinding:
      position: 101
      prefix: -U
  - id: exclude_overlapping_coord
    type:
      - 'null'
      - boolean
    doc: Enable excluding overlapping bases in paired-end reads from first read in
      coordinate-sorted order from coverage statistics.
    inputBinding:
      position: 101
      prefix: -O
  - id: exclude_overlapping_mc
    type:
      - 'null'
      - boolean
    doc: Enable excluding overlapping bases in paired-end reads by determining overlapping
      bases from MC tag.
    inputBinding:
      position: 101
      prefix: -M
  - id: filtered_flags
    type:
      - 'null'
      - int
    doc: Only process records with none of bits in INT set in FLAG.
    inputBinding:
      position: 101
      prefix: -F
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read INPUT as the input SAM, BAM, or CRAM file (stdin). Input must be coordinate-sorted
      for accurate results.
    inputBinding:
      position: 101
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: Specify file format of input alignment file ("sam", "bam", or "cram" available,
      default guessed from filename or "sam").
    inputBinding:
      position: 101
      prefix: -j
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Filter bases with base quality below INT from coverage statistics.
    inputBinding:
      position: 101
      prefix: -b
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Only process records with minimum mapping quality of INT.
    inputBinding:
      position: 101
      prefix: -q
  - id: num_records
    type:
      - 'null'
      - int
    doc: Maximum number of records to keep in memory.
    inputBinding:
      position: 101
      prefix: -n
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Indexed FASTA reference file for CRAM input alignment.
    inputBinding:
      position: 101
      prefix: -T
  - id: regions_bed
    type:
      - 'null'
      - File
    doc: File in BED format listing which regions to process. By default, all available
      records are processed. This option requires the alignment file to be indexed.
    inputBinding:
      position: 101
      prefix: -r
  - id: required_flags
    type:
      - 'null'
      - int
    doc: Only process records with all bits in INT set in FLAG.
    inputBinding:
      position: 101
      prefix: -f
  - id: separate_threads
    type:
      - 'null'
      - boolean
    doc: Use separate threads for reading and processing records (requires builtin
      pthread support).
    inputBinding:
      position: 101
      prefix: -p
  - id: target_bed
    type:
      - 'null'
      - File
    doc: File in BED format listing capture coverage regions. Required if capture
      coverage statistics are enabled.
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose runtime information output to stderr.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write report to OUTPUT (stdout).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignstats:0.11--h7b50bb2_0
