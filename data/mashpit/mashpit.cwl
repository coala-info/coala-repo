cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashpit
label: mashpit
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/tongzhouxu/mashpit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
stdout: mashpit.out
