cwlVersion: v1.2
class: CommandLineTool
baseCommand: circos-tools_build
label: circos-tools_build
doc: "The provided text appears to be a log of a failed container build process (Apptainer/Singularity)
  rather than command-line help text. As a result, no specific CLI arguments, flags,
  or options could be extracted.\n\nTool homepage: http://circos.ca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circos-tools:v0.23-1-deb_cv1
stdout: circos-tools_build.out
