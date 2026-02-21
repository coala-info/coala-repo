cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vtools
  - stats
label: vtools_vtools-stats
doc: "The provided text does not contain help information for the tool, as it is an
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  image. No arguments could be extracted.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools_vtools-stats.out
