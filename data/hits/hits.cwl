cwlVersion: v1.2
class: CommandLineTool
baseCommand: hits
label: hits
doc: "The provided text does not contain help information for the 'hits' tool. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/jeffhussmann/hits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hits:0.4.5--py310h1fe012e_0
stdout: hits.out
