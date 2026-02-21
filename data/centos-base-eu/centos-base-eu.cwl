cwlVersion: v1.2
class: CommandLineTool
baseCommand: centos-base-eu
label: centos-base-eu
doc: "CentOS base image from Biocontainers (Note: The provided text is an error log
  from a container build process and does not contain CLI help documentation or argument
  definitions).\n\nTool homepage: https://github.com/Mikael/VIPBot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centos-base-eu:centos8
stdout: centos-base-eu.out
