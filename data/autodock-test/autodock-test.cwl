cwlVersion: v1.2
class: CommandLineTool
baseCommand: autodock-test
label: autodock-test
doc: "A tool associated with AutoDock testing. Note: The provided text appears to
  be a container build error log rather than command-line help text, so no specific
  arguments could be extracted.\n\nTool homepage: http://autodock.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autodock-test:v4.2.6-6-deb_cv1
stdout: autodock-test.out
