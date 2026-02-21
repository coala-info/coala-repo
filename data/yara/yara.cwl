cwlVersion: v1.2
class: CommandLineTool
baseCommand: yara
label: yara
doc: "The provided text does not contain help information for the tool 'yara'. It
  contains error logs from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.\n\nTool homepage: https://github.com/seqan/seqan/tree/seqan-v2.5.1/apps/yara/README.rst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yara:1.0.5--haf24da9_0
stdout: yara.out
