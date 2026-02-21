cwlVersion: v1.2
class: CommandLineTool
baseCommand: invesalius-bin
label: invesalius-bin
doc: 'InVesalius is a free software for 3D medical imaging reconstruction. (Note:
  The provided text is a container execution error log and does not contain help information
  or argument definitions).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/invesalius-bin:v3.1.99992-3-deb_cv1
stdout: invesalius-bin.out
