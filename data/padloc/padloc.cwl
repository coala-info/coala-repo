cwlVersion: v1.2
class: CommandLineTool
baseCommand: padloc
label: padloc
doc: "Locating Antiviral Defense Systems in Prokaryotic Genomes (Note: The provided
  text contains system error messages rather than help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/padlocbio/padloc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/padloc:2.0.0--hdfd78af_1
stdout: padloc.out
