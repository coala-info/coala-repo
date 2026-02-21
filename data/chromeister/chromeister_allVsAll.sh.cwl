cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromeister_allVsAll.sh
label: chromeister_allVsAll.sh
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding container image extraction
  (no space left on device).\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
stdout: chromeister_allVsAll.sh.out
