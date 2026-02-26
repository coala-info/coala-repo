cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase_pb
label: igda-script_igda_pipe_phase_pb_diploid
doc: "Phase diploid genomes using long reads\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: input_directory
    type: Directory
    doc: Input directory containing phased reads
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference genome file
    inputBinding:
      position: 2
  - id: output_directory
    type: Directory
    doc: Output directory for phased results
    inputBinding:
      position: 3
  - id: max_iterations_ann
    type:
      - 'null'
      - int
    doc: maximal number of iteration in ANN
    default: 1
    inputBinding:
      position: 104
      prefix: -b
  - id: max_nearest_neighbors
    type:
      - 'null'
      - int
    doc: maximal number of nearest neighbors
    default: 50
    inputBinding:
      position: 104
      prefix: -m
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimal coverage of each contig
    default: 10
    inputBinding:
      position: 104
      prefix: -c
  - id: min_jaccard_index
    type:
      - 'null'
      - float
    doc: minimal jaccard index for find_nccontigs and tred
    default: 2.0
    inputBinding:
      position: 104
      prefix: -j
  - id: min_nearest_neighbors
    type:
      - 'null'
      - int
    doc: minimal number of nearest neighbors
    default: 25
    inputBinding:
      position: 104
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 104
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase_pb_diploid.out
