cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit-bamstats04
label: jvarkit-bamstats04
doc: "The provided text is an error message indicating a failure to pull or build
  the container image due to insufficient disk space ('no space left on device').
  No help text or argument information was available in the input.\n\nTool homepage:
  http://lindenb.github.io/jvarkit/BamStats04.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-bamstats04:2025.07.28--hdfd78af_0
stdout: jvarkit-bamstats04.out
