cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_map
label: taxmapper_map
doc: "Map reads to taxa\n\nTool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: combine
    type:
      - 'null'
      - string
    doc: How to combine forward and reverse hits, for "concordant" forward and 
      reverse have to map to the same taxon, for "best" the best hit from 
      forward and reverse is returned
    default: best
    inputBinding:
      position: 101
      prefix: --combine
  - id: forward_file
    type: File
    doc: Forward read aln file
    inputBinding:
      position: 101
      prefix: --forward
  - id: max_length
    type: int
    doc: Maximum read length
    inputBinding:
      position: 101
      prefix: -m
  - id: reverse_file
    type:
      - 'null'
      - File
    doc: Reverse read aln file [optional]
    inputBinding:
      position: 101
      prefix: --reverse
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, used to map forward and reverse reads in parallel
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
