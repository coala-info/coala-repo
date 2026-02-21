cwlVersion: v1.2
class: CommandLineTool
baseCommand: ega-cryptor
label: ega-cryptor_EGA-Cryptor_2_0_0.jar
doc: "EGA-Cryptor is a tool used for encrypting and decrypting files for submission
  to the European Genome-phenome Archive (EGA). (Note: The provided help text contains
  system error messages and does not list specific command-line arguments.)\n\nTool
  homepage: https://ega-archive.org/submission/data/file-preparation/egacryptor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ega-cryptor:2.0.0--hdfd78af_0
stdout: ega-cryptor_EGA-Cryptor_2_0_0.jar.out
