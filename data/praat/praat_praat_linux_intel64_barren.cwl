cwlVersion: v1.2
class: CommandLineTool
baseCommand: praat
label: praat_praat_linux_intel64_barren
doc: "Praat is a tool for doing phonetics by computer, including speech analysis,
  synthesis, and manipulation.\n\nTool homepage: https://github.com/praat/praat.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/praat:v6.0.48-1-deb_cv1
stdout: praat_praat_linux_intel64_barren.out
