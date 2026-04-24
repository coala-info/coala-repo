cwlVersion: v1.2
class: CommandLineTool
baseCommand: amaranth
label: amaranth-assembler_amaranth
doc: "Amaranth assembler for transcript assembly from BAM files\n\nTool homepage:
  https://github.com/Shao-Group/amaranth"
inputs:
  - id: both_umi_support
    type:
      - 'null'
      - string
    doc: require satisfactory UMI support for [both/either] condition
    inputBinding:
      position: 101
      prefix: --both-umi-support
  - id: gene_name_prefix
    type:
      - 'null'
      - string
    doc: prefix to add to gene names in output GTF
    inputBinding:
      position: 101
      prefix: --gene_name_prefix
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: library_type
    type:
      - 'null'
      - string
    doc: library type of the sample (first, second, unstranded)
    inputBinding:
      position: 101
      prefix: --library_type
  - id: max_ir_full_ratio_e
    type:
      - 'null'
      - float
    doc: ratio threshold of retained edge to skip edge (full)
    inputBinding:
      position: 101
      prefix: --max-ir-full-ratio-e
  - id: max_ir_full_ratio_i
    type:
      - 'null'
      - float
    doc: ratio threshold of retained node to its own edge (full)
    inputBinding:
      position: 101
      prefix: --max-ir-full-ratio-i
  - id: max_ir_full_ratio_v
    type:
      - 'null'
      - float
    doc: ratio threshold of retained node to skip edge (full)
    inputBinding:
      position: 101
      prefix: --max-ir-full-ratio-v
  - id: max_ir_part_ratio_e
    type:
      - 'null'
      - float
    doc: ratio threshold of retained edge to skip edge (partial)
    inputBinding:
      position: 101
      prefix: --max-ir-part-ratio-e
  - id: max_ir_part_ratio_v
    type:
      - 'null'
      - float
    doc: ratio threshold of retained node to skip edge (partial)
    inputBinding:
      position: 101
      prefix: --max-ir-part-ratio-v
  - id: max_ir_umi_support_full
    type:
      - 'null'
      - int
    doc: max UMI reads to support full intron retention
    inputBinding:
      position: 101
      prefix: --max-ir-umi-support-full
  - id: max_ir_umi_support_part
    type:
      - 'null'
      - int
    doc: max UMI reads to support partial intron retention
    inputBinding:
      position: 101
      prefix: --max-ir-umi-support-part
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: ignore reads with CIGAR size larger than this value
    inputBinding:
      position: 101
      prefix: --max_num_cigar
  - id: meta
    type:
      - 'null'
      - boolean
    doc: enable meta-assembly mode for multiple cells
    inputBinding:
      position: 101
      prefix: --meta
  - id: min_bundle_gap
    type:
      - 'null'
      - int
    doc: minimum distances required to start a new bundle
    inputBinding:
      position: 101
      prefix: --min_bundle_gap
  - id: min_cb_ratio
    type:
      - 'null'
      - float
    doc: minimum ratio of exons supported by cell barcode
    inputBinding:
      position: 101
      prefix: --min-cb-ratio
  - id: min_flank_length
    type:
      - 'null'
      - int
    doc: minimum match length in each side for a spliced read
    inputBinding:
      position: 101
      prefix: --min_flank_length
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: ignore reads with mapping quality less than this value
    inputBinding:
      position: 101
      prefix: --min_mapping_quality
  - id: min_num_hits_in_bundle
    type:
      - 'null'
      - int
    doc: minimum number of reads required in a gene locus
    inputBinding:
      position: 101
      prefix: --min_num_hits_in_bundle
  - id: min_single_exon_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage required for a single-exon transcript
    inputBinding:
      position: 101
      prefix: --min_single_exon_coverage
  - id: min_transcript_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage required for a multi-exon transcript
    inputBinding:
      position: 101
      prefix: --min_transcript_coverage
  - id: min_transcript_length_base
    type:
      - 'null'
      - int
    doc: minimum length of a transcript would be --min_transcript_length_base + --min_transcript_length_increase
      * num-of-exons
    inputBinding:
      position: 101
      prefix: --min_transcript_length_base
  - id: min_transcript_length_increase
    type:
      - 'null'
      - int
    doc: length increase factor per exon
    inputBinding:
      position: 101
      prefix: --min_transcript_length_increase
  - id: min_umi_ratio_bundle
    type:
      - 'null'
      - float
    doc: minimum ratio of UMI reads required in a bundle
    inputBinding:
      position: 101
      prefix: --min-umi-ratio-bundle
  - id: min_umi_reads_bundle
    type:
      - 'null'
      - int
    doc: minimum number of UMI reads required in a bundle
    inputBinding:
      position: 101
      prefix: --min-umi-reads-bundle
  - id: min_umi_reads_start_exon
    type:
      - 'null'
      - int
    doc: minimum number of UMI reads supporting the first exon
    inputBinding:
      position: 101
      prefix: --min-umi-reads-start-exon
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: disable filtering, use all subpaths in final assembly
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: no_remove_pcr_duplicates
    type:
      - 'null'
      - boolean
    doc: not remove PCR duplicates in the input bam file
    inputBinding:
      position: 101
      prefix: --no-remove-pcr-duplicates
  - id: no_remove_retained_intron
    type:
      - 'null'
      - boolean
    doc: do not remove retained introns
    inputBinding:
      position: 101
      prefix: --no-remove-retained-intron
  - id: preview
    type:
      - 'null'
      - boolean
    doc: determine fragment-length-range and library-type and exit
    inputBinding:
      position: 101
      prefix: --preview
  - id: remove_pcr_duplicates
    type:
      - 'null'
      - int
    doc: 'remove PCR duplicates using strategy: 0,1, or 2'
    inputBinding:
      position: 101
      prefix: --remove-pcr-duplicates
  - id: remove_retained_intron
    type:
      - 'null'
      - boolean
    doc: remove retained introns
    inputBinding:
      position: 101
      prefix: --remove-retained-intron
  - id: use_filter
    type:
      - 'null'
      - boolean
    doc: use filtering to select subpaths before final assembly
    inputBinding:
      position: 101
      prefix: --use-filter
  - id: verbose
    type:
      - 'null'
      - int
    doc: '0: quiet; 1: one line for each graph; 2: with details'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_gtf
    type: File
    doc: Output GTF file
    outputBinding:
      glob: $(inputs.output_gtf)
  - id: transcript_fragments
    type:
      - 'null'
      - File
    doc: file to which the assembled non-full-length transcripts will be written to
    outputBinding:
      glob: $(inputs.transcript_fragments)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amaranth-assembler:0.1.0--h5ca1c30_0
