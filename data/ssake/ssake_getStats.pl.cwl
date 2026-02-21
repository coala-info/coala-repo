cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssake_getStats.pl
label: ssake_getStats.pl
doc: "A script to get statistics for SSAKE (Short Sequence Assembly by K-mer Extension)
  assemblies. Note: The provided help text contains only container runtime errors
  and no usage information.\n\nTool homepage: https://github.com/warrenlr/SSAKE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssake:v4.0-2-deb_cv1
stdout: ssake_getStats.pl.out
