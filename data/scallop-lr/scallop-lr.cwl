cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop-lr
label: scallop-lr
doc: "Scallop-LR v0.9.2 (c) 2018 Mingfu Shao, Carl Kingsford, and Carnegie Mellon
  University\n\nTool homepage: https://github.com/Kingsford-Group/lrassemblyanalysis"
inputs:
  - id: bam_file
    type: File
    doc: input bam-file
    inputBinding:
      position: 101
      prefix: -i
  - id: ccs_header_file
    type: File
    doc: ccs-header-file
    inputBinding:
      position: 101
      prefix: -c
  - id: library_type
    type:
      - 'null'
      - string
    doc: 'library type of the sample, default: unstranded'
    inputBinding:
      position: 101
      prefix: --library_type
  - id: min_boundary_hits
    type:
      - 'null'
      - int
    doc: "minimum number of reads with 5'/3' primes required for a boundary, default:
      3"
    inputBinding:
      position: 101
      prefix: --min_boundary_hits
  - id: min_bundle_gap
    type:
      - 'null'
      - int
    doc: 'minimum distances required to start a new bundle, default: 50'
    inputBinding:
      position: 101
      prefix: --min_bundle_gap
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'ignore reads with mapping quality less than this value, default: 1'
    inputBinding:
      position: 101
      prefix: --min_mapping_quality
  - id: min_num_hits_in_bundle
    type:
      - 'null'
      - int
    doc: 'minimum number of reads required in a bundle, default: 1'
    inputBinding:
      position: 101
      prefix: --min_num_hits_in_bundle
  - id: min_single_exon_coverage
    type:
      - 'null'
      - float
    doc: 'minimum coverage required for a single-exon transcript, default: 10'
    inputBinding:
      position: 101
      prefix: --min_single_exon_coverage
  - id: min_splice_hits
    type:
      - 'null'
      - int
    doc: 'minimum number of spliced reads required for a junction, default: 1'
    inputBinding:
      position: 101
      prefix: --min_splice_hits
  - id: min_transcript_coverage
    type:
      - 'null'
      - float
    doc: 'minimum coverage required for a multi-exon transcript, default: 1.01'
    inputBinding:
      position: 101
      prefix: --min_transcript_coverage
  - id: min_transcript_length_base
    type:
      - 'null'
      - int
    doc: "default: 100, minimum length of a transcript would be\n                \
      \                             --min_transcript_length_base + --min_transcript_length_increase
      * num-of-exons"
    inputBinding:
      position: 101
      prefix: --min_transcript_length_base
  - id: min_transcript_length_increase
    type:
      - 'null'
      - int
    doc: 'default: 50'
    inputBinding:
      position: 101
      prefix: --min_transcript_length_increase
  - id: verbose
    type:
      - 'null'
      - int
    doc: '0: quiet; 1: one line for each graph; 2: with details, default: 1'
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
    dockerPull: quay.io/biocontainers/scallop-lr:0.9.2--h503566f_10
