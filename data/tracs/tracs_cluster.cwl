cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_cluster
label: tracs_cluster
doc: "Groups samples into putative transmission clusters using single linkage clustering\n\
  \nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: distance_file
    type: File
    doc: Pairwise distance estimates obtained from running the 'distance' 
      function
    inputBinding:
      position: 101
      prefix: --distances
  - id: distance_type
    type: string
    doc: The type of transmission distance to use. Can be one of 'snp', 
      'filter', 'direct', 'expectedK'
    inputBinding:
      position: 101
      prefix: --distance
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging threshold.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: threshold
    type: float
    doc: Distance threshold. Samples will be grouped together if the distance 
      between them is below this threshold.
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_file
    type: File
    doc: name of the output file to store the resulting cluster assignments
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
