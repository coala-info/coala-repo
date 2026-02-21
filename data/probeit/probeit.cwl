cwlVersion: v1.2
class: CommandLineTool
baseCommand: probeit
label: probeit
doc: "The provided text does not contain help information for the tool 'probeit'.
  It consists of error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the image.\n\nTool homepage: https://github.com/steineggerlab/probeit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probeit:2.2--py311h8ddd9a4_5
stdout: probeit.out
