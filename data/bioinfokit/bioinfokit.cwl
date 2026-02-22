cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioinfokit
label: bioinfokit
doc: "The provided text is a system error log related to a Singularity/Apptainer container
  execution failure (no space left on device) and does not contain help text or argument
  definitions for the bioinfokit tool.\n\nTool homepage: https://reneshbedre.github.io/blog/howtoinstall.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioinfokit:2.1.3--pyh7cba7a3_0
stdout: bioinfokit.out
