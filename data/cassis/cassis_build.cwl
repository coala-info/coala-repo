cwlVersion: v1.2
class: CommandLineTool
baseCommand: cassis_build
label: cassis_build
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: http://pbil.univ-lyon1.fr/software/Cassis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cassis:0.0.20120106--hdfd78af_1
stdout: cassis_build.out
