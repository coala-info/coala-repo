cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms2pip
label: ms2pip
doc: "MS2 peak intensity prediction\n\nTool homepage: http://compomics.github.io/projects/ms2pip_c"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
stdout: ms2pip.out
