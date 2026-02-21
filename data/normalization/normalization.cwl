cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalization
label: normalization
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions. It indicates
  a failure to pull or build the container image 'biocontainers/normalization:phenomenal-v1.0.6_cv1.1.3'
  due to insufficient disk space.\n\nTool homepage: https://github.com/paularmstrong/normalizr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/normalization:phenomenal-v1.0.6_cv1.1.3
stdout: normalization.out
