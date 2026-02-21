cwlVersion: v1.2
class: CommandLineTool
baseCommand: runjob_runshell
label: runjob_runshell
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log output from a container runtime (Apptainer/Singularity) failure
  during an image build process.\n\nTool homepage: https://github.com/yodeng/runjob"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/runjob:2.10.9--pyhdfd78af_0
stdout: runjob_runshell.out
