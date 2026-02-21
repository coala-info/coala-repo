cwlVersion: v1.2
class: CommandLineTool
baseCommand: chanjo
label: chanjo
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool. As a result,
  no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/Clinical-Genomics/chanjo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chanjo:3.3.0--py27_0
stdout: chanjo.out
