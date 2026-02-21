cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_git-fleximod
label: noresm_git-fleximod
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_git-fleximod.out
