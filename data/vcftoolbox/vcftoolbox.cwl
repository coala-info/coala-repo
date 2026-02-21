cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcftoolbox
label: vcftoolbox
doc: "The provided text does not contain help documentation for vcftoolbox; it contains
  error logs from a container runtime (Singularity/Apptainer) attempting to fetch
  the tool image.\n\nTool homepage: http://github.com/moonso/vcftoolbox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcftoolbox:1.5.1--py_0
stdout: vcftoolbox.out
