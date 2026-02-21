cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybedtools
label: pybedtools-bin_pybedtools
doc: "The provided text does not contain help information; it appears to be a container
  execution error log regarding a failure to fetch an OCI image.\n\nTool homepage:
  https://github.com/daler/pybedtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pybedtools-bin:v0.8.0-1-deb_cv1
stdout: pybedtools-bin_pybedtools.out
