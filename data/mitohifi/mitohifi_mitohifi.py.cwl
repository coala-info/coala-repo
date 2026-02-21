cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitohifi.py
label: mitohifi_mitohifi.py
doc: "The provided text does not contain help information for the tool; it is an error
  message regarding a lack of disk space during a container build process.\n\nTool
  homepage: https://github.com/marcelauliano/MitoHiFi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mitohifi:2.2_cv1
stdout: mitohifi_mitohifi.py.out
