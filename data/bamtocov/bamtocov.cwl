cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamtocov
label: bamtocov
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and error messages related to a container runtime
  (Apptainer/Singularity) failing to build an image due to lack of disk space.\n\n
  Tool homepage: https://github.com/telatin/bamtocov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtocov:2.8.0--h1104d80_0
stdout: bamtocov.out
