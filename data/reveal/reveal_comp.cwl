cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reveal
  - comp
label: reveal_comp
doc: "Reverse complement the graph.\n\nTool homepage: https://github.com/jasperlinthorst/reveal"
inputs:
  - id: graph
    type: File
    doc: The graph to be reverse complemented.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: rc_graph
    type: File
    doc: Reverse complemented graph (input name with .rc.gfa)
    outputBinding:
      glob: $(inputs.graph.nameroot).rc.gfa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.graph)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_comp.out
