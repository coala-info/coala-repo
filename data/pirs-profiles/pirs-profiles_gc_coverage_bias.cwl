cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs-profiles_gc_coverage_bias
label: pirs-profiles_gc_coverage_bias
doc: "The provided text does not contain help information for the tool, but rather
  system error logs indicating a failure to build or extract a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pirs-profiles:v2.0.2dfsg-8-deb_cv1
stdout: pirs-profiles_gc_coverage_bias.out
