cwlVersion: v1.2
class: CommandLineTool
baseCommand: profisis
label: profisis
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a container runtime error log.\n\nTool homepage: https://github.com/Pazzi14/site-profisisonal-2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profisis:v1.0.11-5-deb_cv1
stdout: profisis.out
