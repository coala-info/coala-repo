cwlVersion: v1.2
class: CommandLineTool
baseCommand: epydoc
label: epydoc
doc: "The provided text does not contain help information for epydoc; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/nltk/epydoc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epydoc:3.0.1--py27_0
stdout: epydoc.out
