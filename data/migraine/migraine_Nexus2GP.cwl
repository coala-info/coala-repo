cwlVersion: v1.2
class: CommandLineTool
baseCommand: migraine_Nexus2GP
label: migraine_Nexus2GP
doc: "A tool for converting Nexus files to Genepop format. (Note: The provided help
  text contains system error messages regarding container image building and does
  not list specific command-line arguments.)\n\nTool homepage: http://kimura.univ-montp2.fr/~rousset/Migraine.htm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migraine:0.6.0--h9948957_4
stdout: migraine_Nexus2GP.out
