cwlVersion: v1.2
class: CommandLineTool
baseCommand: ci-proxy
label: ci-proxy
doc: "The provided text appears to be a system error log from a container build process
  rather than command-line help text. As a result, no specific arguments or descriptions
  could be extracted.\n\nTool homepage: https://github.com/cirosantilli/china-dictatorship"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ci-proxy:latest
stdout: ci-proxy.out
