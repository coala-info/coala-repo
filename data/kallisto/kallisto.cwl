cwlVersion: v1.2
class: CommandLineTool
baseCommand: kallisto
label: kallisto
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or convert the kallisto image due to insufficient disk
  space. It does not contain help text or argument definitions.\n\nTool homepage:
  https://pachterlab.github.io/kallisto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.51.1--h2b92561_2
stdout: kallisto.out
