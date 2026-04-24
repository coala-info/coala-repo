cwlVersion: v1.2
class: CommandLineTool
baseCommand: aletsch
label: aletsch
doc: "Aletsch is a tool for assembling transcripts from multiple RNA-seq samples.\n\
  \nTool homepage: https://github.com/Shao-Group/aletsch"
inputs:
  - id: batch_partition_size
    type:
      - 'null'
      - int
    doc: the number of partitions loaded each time
    inputBinding:
      position: 101
      prefix: --batch_partition_size
  - id: boost_precision
    type:
      - 'null'
      - boolean
    doc: 'reduce false positives, default: not to do so'
    inputBinding:
      position: 101
      prefix: --boost_precision
  - id: chrm_list_file
    type:
      - 'null'
      - File
    doc: 'file with chromosomes that will be assembled, default: N/A (i.e., assemble
      all)'
    inputBinding:
      position: 101
      prefix: --chrm_list_file
  - id: chrm_list_string
    type:
      - 'null'
      - string
    doc: 'list of chromosomes that will be assembled, default: N/A (i.e., assemble
      all)'
    inputBinding:
      position: 101
      prefix: --chrm_list_string
  - id: input_bam_list
    type: File
    doc: input-bam-list
    inputBinding:
      position: 101
      prefix: -i
  - id: max_group_size
    type:
      - 'null'
      - int
    doc: the maximized number of splice graphs that will be combined
    inputBinding:
      position: 101
      prefix: --max_group_size
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: ignore reads with CIGAR size larger than this value
    inputBinding:
      position: 101
      prefix: --max_num_cigar
  - id: max_threads
    type:
      - 'null'
      - int
    doc: maximized number of threads
    inputBinding:
      position: 101
      prefix: --max_threads
  - id: min_boundary_log_ratio
    type:
      - 'null'
      - float
    doc: minimum log-ratio to identify a new boundary
    inputBinding:
      position: 101
      prefix: --min_boundary_log_ratio
  - id: min_bridging_score
    type:
      - 'null'
      - float
    doc: the minimum score for bridging a paired-end reads
    inputBinding:
      position: 101
      prefix: --min_bridging_score
  - id: min_bundle_gap
    type:
      - 'null'
      - int
    doc: minimum distances required to start a new bundle
    inputBinding:
      position: 101
      prefix: --min_bundle_gap
  - id: min_flank_length
    type:
      - 'null'
      - int
    doc: minimum match length in each side for a spliced read
    inputBinding:
      position: 101
      prefix: --min_flank_length
  - id: min_grouping_similarity
    type:
      - 'null'
      - float
    doc: the minimized similarity for two graphs to be combined
    inputBinding:
      position: 101
      prefix: --min_grouping_similarity
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
    doc: minimum number of reads required in a bundle
    inputBinding:
      position: 101
      prefix: --min_num_hits_in_bundle
  - id: min_single_exon_clustering_overlap
    type:
      - 'null'
      - float
    doc: minimum overlaping ratio to merge two single-exon transcripts
    inputBinding:
      position: 101
      prefix: --min_single_exon_clustering_overlap
  - id: min_single_exon_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage required for a single-exon transcript
    inputBinding:
      position: 101
      prefix: --min_single_exon_coverage
  - id: min_single_exon_transcript_length
    type:
      - 'null'
      - int
    doc: minimum length of single-exon transcript
    inputBinding:
      position: 101
      prefix: --min_single_exon_transcript_length
  - id: min_splice_bundary_hits
    type:
      - 'null'
      - int
    doc: the minimum number of spliced reads required to support a junction
    inputBinding:
      position: 101
      prefix: --min_splice_bundary_hits
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
    doc: minimum transcript length base
    inputBinding:
      position: 101
      prefix: --min_transcript_length_base
  - id: min_transcript_length_increase
    type:
      - 'null'
      - int
    doc: 'minimum length of a transcript: base + #exons * increase'
    inputBinding:
      position: 101
      prefix: --min_transcript_length_increase
  - id: output_single_exon_transcripts
    type:
      - 'null'
      - boolean
    doc: 'assemble single-exon transcripts, default: not to do so'
    inputBinding:
      position: 101
      prefix: --output_single_exon_transcripts
  - id: profile
    type:
      - 'null'
      - boolean
    doc: profiling individual samples and exit (will write to files if -p 
      provided)
    inputBinding:
      position: 101
      prefix: --profile
  - id: profile_dir
    type:
      - 'null'
      - Directory
    doc: 'existing directory for saving/loading profiles of each samples, default:
      N/A'
    inputBinding:
      position: 101
      prefix: --profile_dir
  - id: region_partition_length
    type:
      - 'null'
      - int
    doc: the length of a partition
    inputBinding:
      position: 101
      prefix: --region_partition_length
outputs:
  - id: output_gtf
    type: File
    doc: output.gtf
    outputBinding:
      glob: $(inputs.output_gtf)
  - id: output_gtf_dir
    type:
      - 'null'
      - Directory
    doc: 'existing directory for individual transcripts, default: N/A'
    outputBinding:
      glob: $(inputs.output_gtf_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aletsch:1.1.3--h503566f_1
