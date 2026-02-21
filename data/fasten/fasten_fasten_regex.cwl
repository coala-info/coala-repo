cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_regex
label: fasten_fasten_regex
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  build an image due to lack of disk space.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_regex.out
