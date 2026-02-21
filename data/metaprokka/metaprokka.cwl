cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaprokka
label: metaprokka
doc: "Prokaryotic genome annotation for metagenomes. (Note: The provided text contains
  container runtime error logs rather than tool help text, so specific arguments could
  not be extracted from the input.)\n\nTool homepage: https://github.com/telatin/metaprokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaprokka:1.15.0--pl5321hdfd78af_0
stdout: metaprokka.out
