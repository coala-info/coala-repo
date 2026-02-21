cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-merge
label: anvio_anvi-merge
doc: "The provided text is a container execution error log (Singularity/Apptainer)
  and does not contain the help text for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-merge.out
