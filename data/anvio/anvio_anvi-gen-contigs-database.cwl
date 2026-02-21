cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-gen-contigs-database
label: anvio_anvi-gen-contigs-database
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-gen-contigs-database.out
