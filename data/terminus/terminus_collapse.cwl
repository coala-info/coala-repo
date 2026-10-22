cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - terminus
  - collapse
label: terminus_collapse
doc: "analyze a collection of per-sample groups, and produce a consensus grouping.\n\
  \nTool homepage: https://github.com/COMBINE-lab/terminus"
inputs:
  - id: consensus_thresh
    type:
      - 'null'
      - float
    doc: threshold for edge consensus
    inputBinding:
      position: 101
      prefix: --consensus-thresh
  - id: dirs
    type:
      type: array
      items: Directory
    doc: salmon quantification directories (one per sample) whose names match the
      per-sample group directories under the output prefix
    inputBinding:
      position: 101
      prefix: --dirs
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use when writing down the collapsed 
      quantifications
    inputBinding:
      position: 101
      prefix: --threads
  - id: group_results
    type: Directory
    doc: output folder of 'terminus group' holding one sub-folder per sample with
      groups.txt; it is staged under the output prefix name
  - id: out_path
    type: string
    doc: prefix where output would be written; must be the folder holding the
      per-sample group results
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: Directory
    doc: prefix where output would be written
    outputBinding:
      glob: $(inputs.out_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_path)
        entry: $(inputs.group_results)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/terminus:v0.1.0--h2db0a6b_0
