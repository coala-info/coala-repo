cwlVersion: v1.2
class: CommandLineTool
baseCommand: damidseq_pipeline_gatc.track.maker.pl
label: damidseq_pipeline_gatc.track.maker.pl
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain the help text or usage information for
  the tool. Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/owenjm/damidseq_pipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damidseq_pipeline:1.6.2--pl5321hdfd78af_0
stdout: damidseq_pipeline_gatc.track.maker.pl.out
