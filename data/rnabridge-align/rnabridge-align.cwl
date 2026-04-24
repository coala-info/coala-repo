cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabridge-align
label: rnabridge-align
doc: "Aligns RNA sequencing reads to a reference genome, identifying bridging reads
  to infer structural variations.\n\nTool homepage: https://github.com/Shao-Group/rnabridge-align"
inputs:
  - id: dp_solution_size
    type:
      - 'null'
      - int
    doc: Candidate number of bridging paths
    inputBinding:
      position: 101
      prefix: --dp_solution_size
  - id: dp_stack_size
    type:
      - 'null'
      - int
    doc: Number of weights maintained for each bridging path
    inputBinding:
      position: 101
      prefix: --dp_stack_size
  - id: flank_tiny_length
    type:
      - 'null'
      - int
    doc: Maximized length for reconsidering error correction
    inputBinding:
      position: 101
      prefix: --flank_tiny_length
  - id: flank_tiny_ratio
    type:
      - 'null'
      - float
    doc: Maximized ratio for reconsidering error correction
    inputBinding:
      position: 101
      prefix: --flank_tiny_ratio
  - id: input_bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: library_type
    type:
      - 'null'
      - string
    doc: Library type of the sample
    inputBinding:
      position: 101
      prefix: --library_type
  - id: max_clustring_flank
    type:
      - 'null'
      - int
    doc: Maximized basepair difference for being in an equivalent class
    inputBinding:
      position: 101
      prefix: --max_clustring_flank
  - id: max_num_cigar
    type:
      - 'null'
      - int
    doc: Ignore reads with CIGAR size larger than this value
    inputBinding:
      position: 101
      prefix: --max_num_cigar
  - id: min_bridging_score
    type:
      - 'null'
      - float
    doc: The minimized bottleneck weight in bridging path
    inputBinding:
      position: 101
      prefix: --min_bridging_score
  - id: min_splice_bundary_hits
    type:
      - 'null'
      - int
    doc: Minimum number of spliced reads required for a junction
    inputBinding:
      position: 101
      prefix: --min_splice_bundary_hits
  - id: preview
    type:
      - 'null'
      - boolean
    doc: Determine fragment-length-range and library-type and exit
    inputBinding:
      position: 101
      prefix: --preview
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference genome file
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_bam_file
    type: File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output_bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabridge-align:1.0.1--h5ca1c30_9
