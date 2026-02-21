cwlVersion: v1.2
class: CommandLineTool
baseCommand: MSAmanda.exe
label: msamanda_MSAmanda.exe
doc: "MSAmanda peptide identification algorithm (Note: The provided text is an error
  log indicating a failure to initialize the container environment and does not contain
  help documentation or argument details).\n\nTool homepage: https://github.com/hgb-bin-proteomics/MSAmanda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/msamanda:v1.0.0.5242_cv4
stdout: msamanda_MSAmanda.exe.out
