cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmidcite_sumpaps
label: pmidcite_sumpaps
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) attempting to fetch
  a Docker image.\n\nTool homepage: http://github.com/dvklopfenstein/pmidcite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
stdout: pmidcite_sumpaps.out
