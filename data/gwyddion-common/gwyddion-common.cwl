cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwyddion-common
label: gwyddion-common
doc: 'Gwyddion is a modular program for SPM (Scanning Probe Microscopy) data visualization
  and analysis. (Note: The provided text contains container runtime error logs rather
  than help documentation.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwyddion-common:v2.52-1-deb_cv1
stdout: gwyddion-common.out
