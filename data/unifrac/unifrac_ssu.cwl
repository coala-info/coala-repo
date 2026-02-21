cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu
label: unifrac_ssu
doc: "The provided text does not contain help information for the tool; it is a fatal
  error log from a container engine (Apptainer/Singularity) failing to fetch a Docker
  image.\n\nTool homepage: https://github.com/biocore/unifrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac:1.5.1--py39hff726c5_0
stdout: unifrac_ssu.out
