cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicycler
label: unicycler-data_unicycler
doc: "Unicycler is a hybrid assembly pipeline for bacterial genomes. (Note: The provided
  text appears to be a container build log rather than help text; no arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/rrwick/Unicycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/unicycler-data:v0.4.7dfsg-2-deb_cv1
stdout: unicycler-data_unicycler.out
