cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamm
label: bamm
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the image due to insufficient disk space.
  It does not contain the tool's help text or argument definitions.\n\nTool homepage:
  https://github.com/Ecogenomics/BamM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamm:1.7.3--py27h790c10a_7
stdout: bamm.out
