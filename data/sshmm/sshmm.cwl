cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshmm
label: sshmm
doc: "The provided text does not contain help information for the tool 'sshmm'. It
  appears to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.molgen.mpg.de/heller/ssHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
stdout: sshmm.out
