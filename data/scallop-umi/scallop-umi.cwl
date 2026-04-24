cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop-umi
label: scallop-umi
doc: "Scallop-UMI v1.1.0 (c) 2021 Qimin Zhang and Mingfu Shao, The Pennsylvania State
  University\n\nTool homepage: https://github.com/Shao-Group/scallop-umi"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: library_type
    type:
      - 'null'
      - string
    doc: library type of the sample
    inputBinding:
      position: 101
      prefix: --library_type
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: ignore reads with CIGAR size larger than this value
    inputBinding:
      position: 101
      prefix: --max_num_cigar
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
    doc: minimum length of a transcript would be --min_transcript_length_base + 
      --min_transcript_length_increase * num-of-exons
    inputBinding:
      position: 101
      prefix: --min_transcript_length_base
  - id: min_transcript_length_increase
    type:
      - 'null'
      - int
    doc: minimum transcript length increase
    inputBinding:
      position: 101
      prefix: --min_transcript_length_increase
  - id: preview
    type:
      - 'null'
      - boolean
    doc: determine fragment-length-range and library-type and exit
    inputBinding:
      position: 101
      prefix: --preview
  - id: verbose
    type:
      - 'null'
      - int
    doc: '0: quiet; 1: one line for each graph; 2: with details'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: gtf_file
    type: File
    doc: Output GTF file
    outputBinding:
      glob: $(inputs.gtf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop-umi:1.1.0--hbce0939_0
