cwlVersion: v1.2
class: CommandLineTool
baseCommand: terminus collapse
label: terminus_collapse
doc: "analyze a collection of per-sample groups, and produce a consensus grouping.\n\
  \nTool homepage: https://github.com/COMBINE-lab/terminus"
inputs:
  - id: consensus_thresh
    type:
      - 'null'
      - float
    doc: threshold for edge consensus
    default: 0.5
    inputBinding:
      position: 101
      prefix: --consensus-thresh
  - id: dirs
    type:
      type: array
      items: Directory
    doc: direcotories to read the group files from
    inputBinding:
      position: 101
      prefix: --dirs
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use when writing down the collapsed 
      quantifications
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: prefix where output would be written
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/terminus:v0.1.0--h2db0a6b_0
