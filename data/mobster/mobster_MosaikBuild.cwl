cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobster_MosaikBuild
label: mobster_MosaikBuild
doc: "A tool for converting sequence data into the MOSAIK binary format. (Note: The
  provided help text contains only system error messages regarding container execution
  and does not list specific arguments).\n\nTool homepage: https://github.com/jyhehir/mobster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobster:0.2.4.1--1
stdout: mobster_MosaikBuild.out
