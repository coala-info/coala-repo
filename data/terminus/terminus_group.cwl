cwlVersion: v1.2
class: CommandLineTool
baseCommand: terminus group
label: terminus_group
doc: "perform per-sample grouping of transcripts; required prior to consensus collapse.\n\
  \nTool homepage: https://github.com/COMBINE-lab/terminus"
inputs:
  - id: dir
    type: Directory
    doc: directory to read input from
    inputBinding:
      position: 101
      prefix: --dir
  - id: min_spread
    type:
      - 'null'
      - float
    doc: the minimum spread a transcript must exhibit to enable an attached edge
      to be a collapse candidate
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-spread
  - id: seed
    type:
      - 'null'
      - int
    doc: The allowable difference between the weights of transcripts in same 
      equivalence classes to treat them as identical
    default: 10
    inputBinding:
      position: 101
      prefix: --seed
  - id: tolerance
    type:
      - 'null'
      - float
    doc: The allowable difference between the weights of transcripts in same 
      equivalence classes to treat them as identical
    default: 0.001
    inputBinding:
      position: 101
      prefix: --tolerance
outputs:
  - id: out
    type: File
    doc: prefix where output would be written
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/terminus:v0.1.0--h2db0a6b_0
