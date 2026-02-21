cwlVersion: v1.2
class: CommandLineTool
baseCommand: scramble
label: staden_io_lib_scramble
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container build/fetch process (Singularity/Apptainer).\n\nTool homepage:
  https://github.com/jkbonfield/io_lib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
stdout: staden_io_lib_scramble.out
