cwlVersion: v1.2
class: CommandLineTool
baseCommand: teal
label: hmftools-teal
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/hartwigmedical/hmftools/blob/master/teal/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-teal:1.3.6--hdfd78af_0
stdout: hmftools-teal.out
