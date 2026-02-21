cwlVersion: v1.2
class: CommandLineTool
baseCommand: jellyfish
label: jellyfish
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or convert the Jellyfish Docker image due to insufficient
  disk space. It does not contain the help text or usage instructions for the Jellyfish
  tool itself.\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
stdout: jellyfish.out
