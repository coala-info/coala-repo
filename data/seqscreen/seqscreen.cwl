cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqscreen
label: seqscreen
doc: "SeqScreen is a software tool for the characterization of short DNA sequences.
  (Note: The provided text appears to be a container build error log rather than help
  text, so no arguments could be extracted.)\n\nTool homepage: https://gitlab.com/treangenlab/seqscreen/-/wikis/home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqscreen:4.5--hdfd78af_0
stdout: seqscreen.out
