cwlVersion: v1.2
class: CommandLineTool
baseCommand: msconvert
label: pwiz_msconvert
doc: "A command-line tool for converting mass spectrometry data files between various
  formats.\n\nTool homepage: https://github.com/ProteoWizard/pwiz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pwiz:phenomenal-v3.0.18205_cv1.2.54
stdout: pwiz_msconvert.out
