cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcriptclean
label: transcriptclean
doc: "The provided text is a system log showing a failed container build (no space
  left on device) and does not contain the help text or usage instructions for the
  tool. Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/mortazavilab/TranscriptClean"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transcriptclean:v2.0.2_cv1
stdout: transcriptclean.out
