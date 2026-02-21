cwlVersion: v1.2
class: CommandLineTool
baseCommand: perlprimer
label: perlprimer
doc: "PerlPrimer is a graphical user interface application for designing primers for
  PCR. (Note: The provided text is a system error log regarding a container build
  failure and does not contain CLI help documentation.)\n\nTool homepage: https://github.com/owenjm/perlprimer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perlprimer:v1.2.4-1-deb_cv1
stdout: perlprimer.out
