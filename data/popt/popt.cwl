cwlVersion: v1.2
class: CommandLineTool
baseCommand: popt
label: popt
doc: "The provided text does not contain help information or usage instructions for
  the tool 'popt'. It appears to be a log from a container runtime (Apptainer/Singularity)
  failure during an image build process.\n\nTool homepage: https://github.com/jerols/PopTut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popt:1.16--0
stdout: popt.out
