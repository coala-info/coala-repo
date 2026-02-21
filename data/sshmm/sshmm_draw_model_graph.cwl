cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshmm_draw_model_graph
label: sshmm_draw_model_graph
doc: "A tool to draw model graphs for SSHMM. (Note: The provided help text contained
  container runtime errors and did not list specific usage or arguments.)\n\nTool
  homepage: https://github.molgen.mpg.de/heller/ssHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
stdout: sshmm_draw_model_graph.out
