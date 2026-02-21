cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShortTracks
label: shortstack_ShortTracks
doc: "A utility within the ShortStack package for small RNA analysis. (Note: The provided
  text is a container build error log and does not contain CLI help information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/MikeAxtell/ShortStack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortstack:4.1.2--hdfd78af_0
stdout: shortstack_ShortTracks.out
