cwlVersion: v1.2
class: CommandLineTool
baseCommand: corgi
label: corgi
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  rather than a command-line help menu. Consequently, no specific arguments, flags,
  or options could be extracted from this text.\n\nTool homepage: https://pypi.org/project/bio-corgi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corgi:0.4.3--pyhdfd78af_0
stdout: corgi.out
