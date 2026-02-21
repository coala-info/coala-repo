cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmer2-pvm
label: hmmer2-pvm
doc: The provided text does not contain help information for the tool. It is an error
  log indicating a failure to pull or build the container image due to lack of disk
  space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hmmer2-pvm:v2.3.2-13-deb_cv1
stdout: hmmer2-pvm.out
