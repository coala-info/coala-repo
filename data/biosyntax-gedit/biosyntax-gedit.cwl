cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosyntax-gedit
label: biosyntax-gedit
doc: The provided text is an error log indicating that the executable 'biosyntax-gedit'
  was not found in the system PATH. No help text or usage information was available
  to extract arguments.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax-gedit:v1.0.0b-1-deb_cv1
stdout: biosyntax-gedit.out
