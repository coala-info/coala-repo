cwlVersion: v1.2
class: CommandLineTool
baseCommand: probcons
label: probcons-extra_probcons
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message indicating a failure to build or
  fetch the SIF image.\n\nTool homepage: http://probcons.stanford.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons-extra:v1.12-12-deb_cv1
stdout: probcons-extra_probcons.out
