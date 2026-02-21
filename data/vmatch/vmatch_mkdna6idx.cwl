cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatch_mkdna6idx
label: vmatch_mkdna6idx
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Apptainer/Singularity) log messages and a fatal error regarding
  an OCI image fetch failure.\n\nTool homepage: http://www.vmatch.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_mkdna6idx.out
