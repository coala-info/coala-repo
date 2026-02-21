cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk
label: slamdunk
doc: "The provided text appears to be a container build log rather than command-line
  help text. No arguments or descriptions could be extracted.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
stdout: slamdunk.out
