cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidfinder
label: plasmidfinder
doc: "The provided text does not contain help information for plasmidfinder; it is
  an error log from a failed container build process (no space left on device).\n\n
  Tool homepage: https://bitbucket.org/genomicepidemiology/plasmidfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidfinder:2.1.6--py314hdfd78af_2
stdout: plasmidfinder.out
