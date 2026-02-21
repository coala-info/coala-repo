cwlVersion: v1.2
class: CommandLineTool
baseCommand: toppas
label: toppas
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: https://github.com/lexcor/TopPasswords"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/toppas:v1.11.1-3_cv3
stdout: toppas.out
