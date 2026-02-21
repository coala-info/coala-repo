cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaweaver_synbiocad
label: dnaweaver_synbiocad
doc: "A tool for DNA assembly design and sequence optimization (Note: The provided
  text contains system error logs rather than CLI help documentation; no arguments
  could be extracted).\n\nTool homepage: https://github.com/brsynth/DNAWeaver_SynBioCAD/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaweaver:v0.3.7--pyhdfd78af_0
stdout: dnaweaver_synbiocad.out
