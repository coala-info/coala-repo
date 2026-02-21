cwlVersion: v1.2
class: CommandLineTool
baseCommand: luigi
label: luigi
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://github.com/spotify/luigi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/luigi:phenomenal-v2.6.0_cv0.1.6
stdout: luigi.out
