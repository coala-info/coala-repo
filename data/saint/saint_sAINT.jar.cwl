cwlVersion: v1.2
class: CommandLineTool
baseCommand: saint
label: saint_sAINT.jar
doc: "Significance Analysis of INTeractome (SAINT). Note: The provided text appears
  to be a container build log rather than CLI help text, so no arguments could be
  extracted.\n\nTool homepage: https://github.com/tiagorlampert/sAINT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/saint:v2.5.0dfsg-3-deb_cv1
stdout: saint_sAINT.jar.out
