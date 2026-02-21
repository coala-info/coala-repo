cwlVersion: v1.2
class: CommandLineTool
baseCommand: smrtanalysis-dev
label: smrtanalysis-dev
doc: 'SMRT Analysis (Pacific Biosciences) development environment. Note: The provided
  text appears to be a container build error log rather than CLI help text, so no
  arguments could be extracted.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smrtanalysis-dev:v020161126-deb_cv1
stdout: smrtanalysis-dev.out
