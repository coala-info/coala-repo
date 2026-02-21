cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmsip
label: cmsip
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cmsip'. It appears to be a system error log related to a container runtime
  (Apptainer/Singularity) failing due to insufficient disk space.\n\nTool homepage:
  https://github.com/lijinbio/cmsip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmsip:0.0.3.0--py_0
stdout: cmsip.out
