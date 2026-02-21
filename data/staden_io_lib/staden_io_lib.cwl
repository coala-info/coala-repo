cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden_io_lib
label: staden_io_lib
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process using Apptainer/Singularity.\n
  \nTool homepage: https://github.com/jkbonfield/io_lib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
stdout: staden_io_lib.out
