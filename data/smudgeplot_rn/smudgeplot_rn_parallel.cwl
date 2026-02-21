cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot_rn_parallel
label: smudgeplot_rn_parallel
doc: "The provided text does not contain help information for the tool; it consists
  of container runtime logs and a fatal error message regarding a container build
  failure.\n\nTool homepage: https://github.com/RNieuwenhuis/smudgeplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_rn_parallel.out
