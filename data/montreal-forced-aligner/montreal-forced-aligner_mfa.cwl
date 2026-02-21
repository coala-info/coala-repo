cwlVersion: v1.2
class: CommandLineTool
baseCommand: mfa
label: montreal-forced-aligner_mfa
doc: "Montreal Forced Aligner (MFA) is a tool for aligning speech audio to text transcripts.
  Note: The provided text contains system error logs regarding container execution
  and does not list command-line arguments.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/montreal-forced-aligner:3.3.8
stdout: montreal-forced-aligner_mfa.out
