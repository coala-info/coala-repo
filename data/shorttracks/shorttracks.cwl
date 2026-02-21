cwlVersion: v1.2
class: CommandLineTool
baseCommand: shorttracks
label: shorttracks
doc: "The provided text does not contain help information for the tool 'shorttracks'.
  It appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://github.com/MikeAxtell/ShortTracks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorttracks:1.3--hdfd78af_0
stdout: shorttracks.out
