cwlVersion: v1.2
class: CommandLineTool
baseCommand: stxtyper
label: stxtyper
doc: "The provided text does not contain help information or argument definitions;
  it is an error log from a container runtime (Singularity/Apptainer) failing to fetch
  the stxtyper image.\n\nTool homepage: https://github.com/ncbi/stxtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stxtyper:1.0.25--hdcf5f25_0
stdout: stxtyper.out
