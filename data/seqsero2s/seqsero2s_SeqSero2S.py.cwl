cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsero2s_SeqSero2S.py
label: seqsero2s_SeqSero2S.py
doc: "Salmonella serotyping from genome sequencing data (Note: The provided text is
  a system error log and does not contain help documentation; no arguments could be
  extracted).\n\nTool homepage: https://github.com/LSTUGA/SeqSero2S"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsero2s:1.1.4--pyhdfd78af_1
stdout: seqsero2s_SeqSero2S.py.out
