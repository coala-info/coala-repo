cwlVersion: v1.2
class: CommandLineTool
baseCommand: scram_flagstat
label: staden_io_lib_scram_flagstat
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/jkbonfield/io_lib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
stdout: staden_io_lib_scram_flagstat.out
