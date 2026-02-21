cwlVersion: v1.2
class: CommandLineTool
baseCommand: arden
label: arden
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.\n\nTool homepage: https://github.com/laravel-ardent/ardent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/arden:v1.0-4-deb_cv1
stdout: arden.out
