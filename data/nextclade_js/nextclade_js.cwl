cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextclade
label: nextclade_js
doc: "The provided text does not contain help information or argument definitions;
  it is an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/nextstrain/nextclade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js.out
