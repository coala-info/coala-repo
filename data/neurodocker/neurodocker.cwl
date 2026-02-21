cwlVersion: v1.2
class: CommandLineTool
baseCommand: neurodocker
label: neurodocker
doc: "A tool to generate custom Dockerfiles and Singularity recipes for neuroimaging
  software.\n\nTool homepage: https://github.com/kaczmarj/neurodocker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neurodocker:0.5.0--py_0
stdout: neurodocker.out
