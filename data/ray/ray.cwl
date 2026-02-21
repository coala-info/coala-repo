cwlVersion: v1.2
class: CommandLineTool
baseCommand: ray
label: ray
doc: "The provided text does not contain help information or usage instructions for
  the tool 'ray'. It appears to be a set of log messages and a fatal error from a
  container runtime (Apptainer/Singularity) attempting to fetch a Docker image.\n\n
  Tool homepage: https://github.com/2dust/v2rayN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ray:v2.3.1-6-deb_cv1
stdout: ray.out
