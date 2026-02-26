cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop2
label: scallop2
doc: "Scallop2 v1.1.2 (c) 2021 Qimin Zhang and Mingfu Shao, The Pennsylvania State
  University\n\nTool homepage: https://github.com/Shao-Group/scallop2"
inputs:
  - id: assemble_duplicates
    type:
      - 'null'
      - int
    doc: 'the number of consensus runs of the decomposition, default: 10'
    default: 10
    inputBinding:
      position: 101
      prefix: --assemble_duplicates
  - id: bam_file
    type: File
    doc: input bam-file
    inputBinding:
      position: 101
      prefix: -i
  - id: library_type
    type:
      - 'null'
      - string
    doc: 'library type of the sample, default: unstranded'
    default: unstranded
    inputBinding:
      position: 101
      prefix: --library_type
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: 'ignore reads with CIGAR size larger than this value, default: 1000'
    default: 1000
    inputBinding:
      position: 101
      prefix: --max_num_cigar
  - id: min_bundle_gap
    type:
      - 'null'
      - int
    doc: 'minimum distances required to start a new bundle, default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --min_bundle_gap
  - id: min_flank_length
    type:
      - 'null'
      - int
    doc: 'minimum match length in each side for a spliced read, default: 3'
    default: 3
    inputBinding:
      position: 101
      prefix: --min_flank_length
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'ignore reads with mapping quality less than this value, default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --min_mapping_quality
  - id: min_num_hits_in_bundle
    type:
      - 'null'
      - int
    doc: 'minimum number of reads required in a bundle, default: 10'
    default: 10
    inputBinding:
      position: 101
      prefix: --min_num_hits_in_bundle
  - id: min_single_exon_coverage
    type:
      - 'null'
      - float
    doc: 'minimum coverage required for a single-exon transcript, default: 20'
    default: 20
    inputBinding:
      position: 101
      prefix: --min_single_exon_coverage
  - id: min_transcript_coverage
    type:
      - 'null'
      - float
    doc: 'minimum coverage required for a multi-exon transcript, default: 0.5'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min_transcript_coverage
  - id: min_transcript_length_base
    type:
      - 'null'
      - int
    doc: "default: 150, minimum length of a transcript would be\n                \
      \                             --min_transcript_length_base + --min_transcript_length_increase
      * num-of-exons"
    default: 150
    inputBinding:
      position: 101
      prefix: --min_transcript_length_base
  - id: min_transcript_length_increase
    type:
      - 'null'
      - int
    doc: 'default: 50'
    default: 50
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
    doc: '0: quiet; 1: one line for each graph; 2: with details, default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: gtf_file
    type: File
    doc: output gtf-file
    outputBinding:
      glob: $(inputs.gtf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop2:1.1.2--h5ca1c30_8
