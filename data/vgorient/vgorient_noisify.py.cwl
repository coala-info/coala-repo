cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgorient_noisify.py
label: vgorient_noisify.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) while attempting
  to fetch a Docker image.\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient_noisify.py.out
