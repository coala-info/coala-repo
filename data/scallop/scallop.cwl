cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop
label: scallop
doc: "Scallop v0.10.5 (c) 2017 Mingfu Shao, Carl Kingsford, and Carnegie Mellon University\n\
  \nTool homepage: https://github.com/Kingsford-Group/scallop"
inputs:
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
    doc: library type of the sample
    inputBinding:
      position: 101
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: ignore reads with CIGAR size larger than this value
    inputBinding:
      position: 101
  - id: min_bundle_gap
    type:
      - 'null'
      - int
    doc: minimum distances required to start a new bundle
    inputBinding:
      position: 101
  - id: min_flank_length
    type:
      - 'null'
      - int
    doc: minimum match length in each side for a spliced read
    inputBinding:
      position: 101
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: ignore reads with mapping quality less than this value
    inputBinding:
      position: 101
  - id: min_num_hits_in_bundle
    type:
      - 'null'
      - int
    doc: minimum number of reads required in a bundle
    inputBinding:
      position: 101
  - id: min_single_exon_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage required for a single-exon transcript
    inputBinding:
      position: 101
  - id: min_splice_bundary_hits
    type:
      - 'null'
      - int
    doc: minimum number of spliced reads required for a junction
    inputBinding:
      position: 101
  - id: min_transcript_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage required for a multi-exon transcript
    inputBinding:
      position: 101
  - id: min_transcript_length_base
    type:
      - 'null'
      - int
    doc: 'default: 150, minimum length of a transcript would be --min_transcript_length_base
      + --min_transcript_length_increase * num-of-exons'
    inputBinding:
      position: 101
  - id: min_transcript_length_increase
    type:
      - 'null'
      - int
    doc: 'default: 50'
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - int
    doc: '0: quiet; 1: one line for each graph; 2: with details'
    inputBinding:
      position: 101
outputs:
  - id: output_gtf
    type: File
    doc: Output GTF file
    outputBinding:
      glob: $(inputs.output_gtf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop:0.10.5--hea69786_9
