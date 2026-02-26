cwlVersion: v1.2
class: CommandLineTool
baseCommand: perlprimer
label: perlprimer
doc: "PerlPrimer is a graphical design tool for PCR primers. It calculates melting
  temperatures using accurate near-neighbor thermodynamic parameters.\n\nTool homepage:
  https://github.com/owenjm/perlprimer"
inputs:
  - id: project_file
    type:
      - 'null'
      - File
    doc: Optional PerlPrimer project file (.ppr) to open on startup
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perlprimer:v1.2.4-1-deb_cv1
stdout: perlprimer.out
