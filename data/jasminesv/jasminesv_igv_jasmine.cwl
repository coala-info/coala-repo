cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasmine
label: jasminesv_igv_jasmine
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the docker image due to insufficient disk space.\n\nTool homepage: https://github.com/mkirsche/Jasmine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
stdout: jasminesv_igv_jasmine.out
