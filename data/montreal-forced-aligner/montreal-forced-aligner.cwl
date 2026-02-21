cwlVersion: v1.2
class: CommandLineTool
baseCommand: montreal-forced-aligner
label: montreal-forced-aligner
doc: "Montreal Forced Aligner (MFA) is a command-line utility for performing forced
  alignment of speech datasets using Kaldi.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
stdout: montreal-forced-aligner.out
