cwlVersion: v1.2
class: CommandLineTool
baseCommand: autogrid-test
label: autogrid-test
doc: "The provided text contains error logs related to a failed container execution
  (no space left on device) and does not contain help information or argument definitions
  for the tool.\n\nTool homepage: http://autodock.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autogrid-test:v4.2.6-6-deb_cv1
stdout: autogrid-test.out
