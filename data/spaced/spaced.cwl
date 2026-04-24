cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./spaced
label: spaced
doc: "Alignment-free sequence comparison tool using spaced word frequencies\n\nTool
  homepage: https://github.com/spacedriveapp/spacedrive"
inputs:
  - id: sequence_file
    type: File
    doc: Sequence file
    inputBinding:
      position: 1
  - id: consider_reverse_complement
    type:
      - 'null'
      - boolean
    doc: don't consider the reverse complement
    inputBinding:
      position: 102
      prefix: -r
  - id: distance_type
    type:
      - 'null'
      - string
    doc: change distance type to Euclidean, Jensen-Shannon, evolutionary 
      distance
    inputBinding:
      position: 102
      prefix: -d
  - id: num_patterns
    type:
      - 'null'
      - int
    doc: number of patterns
    inputBinding:
      position: 102
      prefix: -n
  - id: pattern_dont_care_positions
    type:
      - 'null'
      - int
    doc: pattern don't care positions
    inputBinding:
      position: 102
      prefix: -l
  - id: pattern_weight
    type:
      - 'null'
      - int
    doc: pattern weight
    inputBinding:
      position: 102
      prefix: -k
  - id: patterns_file
    type:
      - 'null'
      - File
    doc: use patterns in <file> instead of random patterns
    inputBinding:
      position: 102
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: numer of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/spaced:v1.2.0-201605dfsg-1-deb_cv1
