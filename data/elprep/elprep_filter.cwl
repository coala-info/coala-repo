cwlVersion: v1.2
class: CommandLineTool
baseCommand: elprep filter
label: elprep_filter
doc: "Filter SAM/BAM/CRAM files.\n\nTool homepage: https://github.com/ExaScience/elprep"
inputs:
  - id: sam_file
    type: File
    doc: Input SAM/BAM/CRAM file
    inputBinding:
      position: 1
  - id: activity_profile
    type:
      - 'null'
      - File
    doc: Activity profile IGV file
    inputBinding:
      position: 102
      prefix: --activity-profile
  - id: assembly_region_padding
    type:
      - 'null'
      - int
    doc: Padding for assembly regions
    inputBinding:
      position: 102
      prefix: --assembly-region-padding
  - id: assembly_regions
    type:
      - 'null'
      - File
    doc: Assembly regions IGV file
    inputBinding:
      position: 102
      prefix: --assembly-regions
  - id: bqsr
    type:
      - 'null'
      - File
    doc: Base Quality Score Recalibration file
    inputBinding:
      position: 102
      prefix: --bqsr
  - id: clean_sam
    type:
      - 'null'
      - boolean
    doc: Clean SAM file
    inputBinding:
      position: 102
      prefix: --clean-sam
  - id: filter_mapping_quality
    type:
      - 'null'
      - int
    doc: Filter reads with mapping quality below a threshold
    inputBinding:
      position: 102
      prefix: --filter-mapping-quality
  - id: filter_non_exact_mapping_reads
    type:
      - 'null'
      - boolean
    doc: Filter non-exact mapping reads
    inputBinding:
      position: 102
      prefix: --filter-non-exact-mapping-reads
  - id: filter_non_exact_mapping_reads_strict
    type:
      - 'null'
      - boolean
    doc: Filter non-exact mapping reads strictly
    inputBinding:
      position: 102
      prefix: --filter-non-exact-mapping-reads-strict
  - id: filter_non_overlapping_reads
    type:
      - 'null'
      - File
    doc: Filter reads that do not overlap with a BED file
    inputBinding:
      position: 102
      prefix: --filter-non-overlapping-reads
  - id: filter_unmapped_reads
    type:
      - 'null'
      - boolean
    doc: Filter unmapped reads
    inputBinding:
      position: 102
      prefix: --filter-unmapped-reads
  - id: filter_unmapped_reads_strict
    type:
      - 'null'
      - boolean
    doc: Filter unmapped reads strictly
    inputBinding:
      position: 102
      prefix: --filter-unmapped-reads-strict
  - id: haplotypecaller
    type:
      - 'null'
      - File
    doc: Haplotype caller VCF file
    inputBinding:
      position: 102
      prefix: --haplotypecaller
  - id: keep_optional_fields
    type:
      - 'null'
      - string
    doc: Keep optional fields (none or a list)
    inputBinding:
      position: 102
      prefix: --keep-optional-fields
  - id: known_sites
    type:
      - 'null'
      - type: array
        items: string
    doc: List of known sites VCF files
    inputBinding:
      position: 102
      prefix: --known-sites
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: Path for log files
    inputBinding:
      position: 102
      prefix: --log-path
  - id: mark_duplicates
    type:
      - 'null'
      - boolean
    doc: Mark duplicate reads
    inputBinding:
      position: 102
      prefix: --mark-duplicates
  - id: mark_optical_duplicates
    type:
      - 'null'
      - File
    doc: Mark optical duplicate reads from a file
    inputBinding:
      position: 102
      prefix: --mark-optical-duplicates
  - id: max_cycle
    type:
      - 'null'
      - int
    doc: Maximum cycle number
    inputBinding:
      position: 102
      prefix: --max-cycle
  - id: nr_of_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --nr-of-threads
  - id: optical_duplicates_pixel_distance
    type:
      - 'null'
      - int
    doc: Pixel distance for optical duplicate detection
    inputBinding:
      position: 102
      prefix: --optical-duplicates-pixel-distance
  - id: output_type
    type:
      - 'null'
      - string
    doc: Output file type (sam | bam)
    inputBinding:
      position: 102
      prefix: --output-type
  - id: quantize_levels
    type:
      - 'null'
      - int
    doc: Number of quantization levels
    inputBinding:
      position: 102
      prefix: --quantize-levels
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference FASTA file
    inputBinding:
      position: 102
      prefix: --reference
  - id: reference_confidence
    type:
      - 'null'
      - string
    doc: Reference confidence mode (GVCF | BP_RESOLUTION | NONE)
    inputBinding:
      position: 102
      prefix: --reference-confidence
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove duplicate reads
    inputBinding:
      position: 102
      prefix: --remove-duplicates
  - id: remove_optional_fields
    type:
      - 'null'
      - string
    doc: Remove optional fields (all or a list)
    inputBinding:
      position: 102
      prefix: --remove-optional-fields
  - id: replace_read_group
    type:
      - 'null'
      - string
    doc: Replace read group information with a string
    inputBinding:
      position: 102
      prefix: --replace-read-group
  - id: replace_reference_sequences
    type:
      - 'null'
      - File
    doc: Replace reference sequences with sequences from a SAM file
    inputBinding:
      position: 102
      prefix: --replace-reference-sequences
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 102
      prefix: --sample-name
  - id: sorting_order
    type:
      - 'null'
      - string
    doc: Keep or set sorting order (keep | unknown | unsorted | queryname | 
      coordinate)
    inputBinding:
      position: 102
      prefix: --sorting-order
  - id: sqq
    type:
      - 'null'
      - type: array
        items: string
    doc: List of SQQ values
    inputBinding:
      position: 102
      prefix: --sqq
  - id: target_regions
    type:
      - 'null'
      - boolean
    doc: Use target regions
    inputBinding:
      position: 102
      prefix: --target-regions
  - id: timed
    type:
      - 'null'
      - boolean
    doc: Enable timing information
    inputBinding:
      position: 102
      prefix: --timed
outputs:
  - id: sam_output_file
    type: File
    doc: Output SAM/BAM/CRAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elprep:5.1.3--he881be0_2
