cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportText
label: krona_ktImportText
doc: "The provided text is a system error log (Apptainer/Singularity failure) and
  does not contain help information or argument definitions for the tool. No arguments
  could be extracted.\n\nTool homepage: https://github.com/marbl/Krona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktImportText.out
