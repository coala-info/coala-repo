cwlVersion: v1.2
class: CommandLineTool
baseCommand: praatcon
label: praat_praatcon
doc: "Praat: doing phonetics by computer (console version)\n\nTool homepage: https://github.com/praat/praat.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/praat:v6.0.48-1-deb_cv1
stdout: praat_praatcon.out
