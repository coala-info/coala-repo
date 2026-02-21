cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidcommunity
label: plasmidcommunity
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain CLI help information, usage instructions, or argument definitions.\n
  \nTool homepage: https://github.com/wuxinmiao5/PlasmidCommunity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
stdout: plasmidcommunity.out
