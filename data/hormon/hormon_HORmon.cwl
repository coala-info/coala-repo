cwlVersion: v1.2
class: CommandLineTool
baseCommand: HORmon
label: hormon_HORmon
doc: "updating monomers to make it consistent with CE postulate, and canonical HOR
  inferencing\n\nTool homepage: https://github.com/ablab/HORmon"
inputs:
  - id: cen_id
    type:
      - 'null'
      - string
    doc: chromosome id
    inputBinding:
      position: 101
      prefix: --cen-id
  - id: min_count_fraction
    type:
      - 'null'
      - float
    doc: minCountFraction. Remove edges in monomer-graph with multiplicite below
      min(MinEdgeMultiplicite, minCountFraction * (min occurrence of valuable 
      monomer))
    inputBinding:
      position: 101
      prefix: --min-count-fraction
  - id: min_edge_multiplicity
    type:
      - 'null'
      - int
    doc: MinEdgeMultiplicite. Remove edges in monomer-graph with multiplicite 
      below min(MinEdgeMultiplicite, minCountFraction * (min occurrence of 
      valuable monomer))
    inputBinding:
      position: 101
      prefix: --min-edge-multiplicity
  - id: min_traversals
    type:
      - 'null'
      - int
    doc: minimum HOR(or monocycle) occurance
    inputBinding:
      position: 101
      prefix: --min-traversals
  - id: mon
    type: File
    doc: path to initial monomers
    inputBinding:
      position: 101
      prefix: --mon
  - id: monomer_thr
    type:
      - 'null'
      - int
    doc: Minimum weight for valuable monomers
    inputBinding:
      position: 101
      prefix: --monomer-thr
  - id: monorun
    type:
      - 'null'
      - boolean
    doc: build and show monorun graphs
    inputBinding:
      position: 101
      prefix: --monorun
  - id: original_mn
    type:
      - 'null'
      - File
    doc: path to original monomer only for comparing
    inputBinding:
      position: 101
      prefix: --original_mn
  - id: seq
    type: File
    doc: path to centromere sequence
    inputBinding:
      position: 101
      prefix: --seq
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: outdir
    type: Directory
    doc: path to output directore
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0
