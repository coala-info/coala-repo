cwlVersion: v1.2
class: CommandLineTool
baseCommand: expansionhunterdenovo
label: expansionhunterdenovo
doc: "The provided text does not contain help information or a description of the
  tool; it contains environment information and a fatal error message regarding a
  container build failure (no space left on device).\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h0cd1d96_4
stdout: expansionhunterdenovo.out
