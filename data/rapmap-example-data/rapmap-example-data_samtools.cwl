cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: rapmap-example-data_samtools
doc: "The provided text is a log of a failed container build process and does not
  contain help information or usage instructions for the command-line tool.\n\nTool
  homepage: https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap-example-data:v0.12.0dfsg-3-deb_cv1
stdout: rapmap-example-data_samtools.out
