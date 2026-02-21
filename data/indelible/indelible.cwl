cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelible
label: indelible
doc: "INDELible is a program for the simulation of biological sequence evolution.
  (Note: The provided text was an error log and did not contain usage information;
  arguments could not be extracted from the source text).\n\nTool homepage: https://github.com/HurlesGroupSanger/indelible"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/indelible:v1.03-4-deb_cv1
stdout: indelible.out
