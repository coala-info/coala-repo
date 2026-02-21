cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgpbigwig
label: cgpbigwig
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://github.com/cancerit/cgpBigWig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
stdout: cgpbigwig.out
