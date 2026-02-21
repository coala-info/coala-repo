cwlVersion: v1.2
class: CommandLineTool
baseCommand: svanalyzer_SVbenchmark
label: svanalyzer_SVbenchmark
doc: "Structural variant benchmarking tool. (Note: The provided help text contains
  only container runtime error logs and does not include usage information or argument
  definitions.)\n\nTool homepage: http://svanalyzer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svanalyzer:0.36--pl5321hdfd78af_2
stdout: svanalyzer_SVbenchmark.out
