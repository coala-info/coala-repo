cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgdi
label: wgdi
doc: "The provided text appears to be a container build error log rather than CLI
  help text. No command-line arguments or tool descriptions could be extracted.\n\n
  Tool homepage: https://github.com/SunPengChuan/wgdi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgdi:0.75--pyhdfd78af_0
stdout: wgdi.out
