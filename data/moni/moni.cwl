cwlVersion: v1.2
class: CommandLineTool
baseCommand: moni
label: moni
doc: "The provided text does not contain help information or usage instructions for
  the tool 'moni'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container due to lack of disk space.\n\nTool homepage:
  https://github.com/maxrossi91/moni"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py310h026fc6c_1
stdout: moni.out
