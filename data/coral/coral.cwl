cwlVersion: v1.2
class: CommandLineTool
baseCommand: coral
label: coral
doc: "Coral v1.0.0 (c) 2019 Mingfu Shao, The Pennsylvania State University\n\nTool
  homepage: https://github.com/Shao-Group/coral"
inputs:
  - id: dp_solution_size
    type:
      - 'null'
      - int
    doc: candidate number of bridgign paths
    inputBinding:
      position: 101
      prefix: --dp_solution_size
  - id: dp_stack_size
    type:
      - 'null'
      - int
    doc: number of weights maintained for each bridging path
    inputBinding:
      position: 101
      prefix: --dp_stack_size
  - id: flank_tiny_length
    type:
      - 'null'
      - int
    doc: maximized length for reconsidering error correction
    inputBinding:
      position: 101
      prefix: --flank_tiny_length
  - id: flank_tiny_ratio
    type:
      - 'null'
      - float
    doc: maximized ratio for reconsidering error correction
    inputBinding:
      position: 101
      prefix: --flank_tiny_ratio
  - id: input_bam_file
    type: File
    doc: input-bam-file
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
  - id: max_clustring_flank
    type:
      - 'null'
      - int
    doc: maximized basepair difference for being in an equivalent class
    inputBinding:
      position: 101
      prefix: --max_clustring_flank
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: ignore reads with CIGAR size larger than this value
    inputBinding:
      position: 101
      prefix: --max_num_cigar
  - id: min_bridging_score
    type:
      - 'null'
      - float
    doc: the minimized bottleneck weight in bridging path
    inputBinding:
      position: 101
      prefix: --min_bridging_score
  - id: min_splice_bundary_hits
    type:
      - 'null'
      - int
    doc: minimum number of spliced reads required for a junction
    inputBinding:
      position: 101
      prefix: --min_splice_bundary_hits
  - id: preview
    type:
      - 'null'
      - boolean
    doc: determine fragment-length-range and library-type and exit
    inputBinding:
      position: 101
      prefix: --preview
  - id: refernece
    type:
      - 'null'
      - File
    doc: refernece
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_bam_file
    type: File
    doc: output-bam-file
    outputBinding:
      glob: $(inputs.output_bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coral:1.0.0--hf5e1fbb_1
