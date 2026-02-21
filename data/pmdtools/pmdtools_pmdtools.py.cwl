cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmdtools.py
label: pmdtools_pmdtools.py
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process. No arguments or usage patterns could be extracted
  from the input.\n\nTool homepage: https://github.com/pontussk/PMDtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmdtools:0.60--hdfd78af_3
stdout: pmdtools_pmdtools.py.out
