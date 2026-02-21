cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaas
label: gaas
doc: "The provided text does not contain help information or usage instructions for
  the tool 'gaas'. It contains system log messages and a fatal error indicating a
  failure to build a Singularity/Apptainer container due to insufficient disk space.\n
  \nTool homepage: https://github.com/NBISweden/GAAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
stdout: gaas.out
