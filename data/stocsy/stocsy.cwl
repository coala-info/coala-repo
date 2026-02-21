cwlVersion: v1.2
class: CommandLineTool
baseCommand: stocsy
label: stocsy
doc: "Statistical Total Correlation Spectroscopy (Note: The provided text is a container
  build log and does not contain CLI help information.)\n\nTool homepage: https://github.com/cheminfo-js/stocsy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stocsy:phenomenal-v0.1.9_cv0.3.2.1
stdout: stocsy.out
