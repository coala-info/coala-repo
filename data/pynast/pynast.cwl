cwlVersion: v1.2
class: CommandLineTool
baseCommand: pynast
label: pynast
doc: "The provided text does not contain help information for pynast; it is an error
  log from a container build process. No arguments could be extracted.\n\nTool homepage:
  https://github.com/SteveDoyle2/pyNastran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pynast:v1.2.2-4-deb_cv1
stdout: pynast.out
