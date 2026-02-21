cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabolab
label: metabolab
doc: "MetaboLab is a software package for the analysis of NMR data. (Note: The provided
  text appears to be a container runtime error log rather than CLI help text, so no
  arguments could be extracted).\n\nTool homepage: https://github.com/ludwigc/metabolabpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metabolab:phenomenal-v2018.01171502_cv0.1.84
stdout: metabolab.out
