cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - elprep
  - sfm
label: elprep_sfm
doc: "sfm parameters:\n\nTool homepage: https://github.com/ExaScience/elprep"
inputs:
  - id: sam_file
    type: File
    doc: Input SAM file
    inputBinding:
      position: 1
  - id: sam_output_name
    type: string
    doc: Name of the output SAM/BAM file
    inputBinding:
      position: 2
  - id: activity_profile
    type:
      - 'null'
      - string
    doc: Output activity profile IGV file (name of the file to write)
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
      - string
    doc: Output assembly regions IGV file (name of the file to write)
    inputBinding:
      position: 102
      prefix: --assembly-regions
  - id: bqsr
    type:
      - 'null'
      - string
    doc: Output base quality score recalibration table (name of the file to 
      write); the tool requires a file name
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
  - id: contig_group_size
    type:
      - 'null'
      - int
    doc: Size of contig groups
    inputBinding:
      position: 102
      prefix: --contig-group-size
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
    doc: Filter out non-exact mapping reads
    inputBinding:
      position: 102
      prefix: --filter-non-exact-mapping-reads
  - id: filter_non_exact_mapping_reads_strict
    type:
      - 'null'
      - boolean
    doc: Filter out non-exact mapping reads strictly
    inputBinding:
      position: 102
      prefix: --filter-non-exact-mapping-reads-strict
  - id: filter_non_overlapping_reads
    type:
      - 'null'
      - File
    doc: Filter out reads that do not overlap with a BED file
    inputBinding:
      position: 102
      prefix: --filter-non-overlapping-reads
  - id: filter_unmapped_reads
    type:
      - 'null'
      - boolean
    doc: Filter out unmapped reads
    inputBinding:
      position: 102
      prefix: --filter-unmapped-reads
  - id: filter_unmapped_reads_strict
    type:
      - 'null'
      - boolean
    doc: Filter out unmapped reads strictly
    inputBinding:
      position: 102
      prefix: --filter-unmapped-reads-strict
  - id: haplotypecaller
    type:
      - 'null'
      - string
    doc: Output VCF file from the haplotype caller (name of the file to write)
    inputBinding:
      position: 102
      prefix: --haplotypecaller
  - id: intermediate_files_output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for intermediate files
    inputBinding:
      position: 102
      prefix: --intermediate-files-output-prefix
  - id: intermediate_files_output_type
    type:
      - 'null'
      - string
    doc: Output type for intermediate files (sam or bam)
    inputBinding:
      position: 102
      prefix: --intermediate-files-output-type
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
        items: File
    doc: List of known sites elsites files (made with vcf-to-elsites or 
      bed-to-elsites)
    inputBinding:
      position: 102
      prefix: --known-sites
      itemSeparator: ','
  - id: log_path
    type:
      - 'null'
      - string
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
      - string
    doc: Output optical duplicates metrics file (name of the file to write)
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
    doc: Output file type (sam or bam)
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
    doc: Reference elFASTA file (made with fasta-to-elfasta)
    inputBinding:
      position: 102
      prefix: --reference
  - id: reference_confidence
    type:
      - 'null'
      - string
    doc: Reference confidence mode (GVCF, BP_RESOLUTION, NONE)
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
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Process as single-end reads
    inputBinding:
      position: 102
      prefix: --single-end
  - id: sorting_order
    type:
      - 'null'
      - string
    doc: Set sorting order (keep, unknown, unsorted, queryname, coordinate)
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
      itemSeparator: ','
  - id: target_regions
    type:
      - 'null'
      - File
    doc: BED file for target regions
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
  - id: tmp_path
    type:
      - 'null'
      - string
    doc: Path for temporary files
    inputBinding:
      position: 102
      prefix: --tmp-path
outputs:
  - id: sam_output_file
    type: File
    doc: Output SAM file
    outputBinding:
      glob: '$(inputs.sam_output_name)'
  - id: activity_profile_file
    type:
      - 'null'
      - File
    doc: Output activity profile IGV file
    outputBinding:
      glob: $(inputs.activity_profile)
  - id: assembly_regions_file
    type:
      - 'null'
      - File
    doc: Output assembly regions IGV file
    outputBinding:
      glob: $(inputs.assembly_regions)
  - id: haplotypecaller_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file from the haplotype caller
    outputBinding:
      glob: $(inputs.haplotypecaller)
  - id: optical_duplicates_metrics
    type:
      - 'null'
      - File
    doc: Output optical duplicates metrics file
    outputBinding:
      glob: $(inputs.mark_optical_duplicates)
  - id: bqsr_recal_file
    type:
      - 'null'
      - File
    doc: Output base quality score recalibration table
    outputBinding:
      glob: $(inputs.bqsr)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elprep:5.1.3--he881be0_2
