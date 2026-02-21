cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfflib
label: cfflib
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container build process (Apptainer/Singularity) indicating
  a 'no space left on device' failure while fetching the cfflib image.\n\nTool homepage:
  https://github.com/LTS5/cfflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cfflib:v2.0.5-3-deb-py2_cv1
stdout: cfflib.out
