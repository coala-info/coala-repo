cwlVersion: v1.2
class: CommandLineTool
baseCommand: umis
label: umis
doc: "The provided text does not contain help information for the 'umis' tool. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the container image.\n\nTool homepage: https://github.com/vals/umis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis.out
