cwlVersion: v1.2
class: CommandLineTool
baseCommand: transtermhp
label: transtermhp
doc: "The provided text is an error log indicating a failure to build or extract the
  container image (no space left on device) and does not contain the help text for
  the tool.\n\nTool homepage: http://transterm.cbcb.umd.edu/index.php"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transtermhp:v2.09-4-deb_cv1
stdout: transtermhp.out
