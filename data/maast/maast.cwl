cwlVersion: v1.2
class: CommandLineTool
baseCommand: maast
label: maast
doc: "The provided text does not contain help information for the tool 'maast'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/zjshi/Maast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maast:1.0.8--py310ha1cbcee_2
stdout: maast.out
