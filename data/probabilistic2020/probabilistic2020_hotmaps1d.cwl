cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - probabilistic2020
  - hotmaps1d
label: probabilistic2020_hotmaps1d
doc: "The provided text does not contain help information for the tool, but appears
  to be a log of a failed container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/KarchinLab/probabilistic2020"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probabilistic2020:1.2.3--py36hd5865be_5
stdout: probabilistic2020_hotmaps1d.out
