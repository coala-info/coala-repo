cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscanfcs
label: pyscanfcs
doc: "Scientific tool for Scanning Fluorescence Correlation Spectroscopy (Note: The
  provided text is a container build error log and does not contain CLI help information).\n
  \nTool homepage: https://github.com/FCS-analysis/PyScanFCS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pyscanfcs:v0.3.2ds-2-deb_cv1
stdout: pyscanfcs.out
