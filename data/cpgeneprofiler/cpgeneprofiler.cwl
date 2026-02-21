cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpgeneprofiler
label: cpgeneprofiler
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log describing a failure to build a Singularity/Apptainer image
  due to insufficient disk space.\n\nTool homepage: https://github.com/ramadatta/CPgeneProfiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpgeneprofiler:2.1.1--r44hdfd78af_5
stdout: cpgeneprofiler.out
