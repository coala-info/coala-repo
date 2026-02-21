cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmntrimmer_RenderingReportFile.py
label: hmntrimmer_RenderingReportFile.py
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/guillaume-gricourt/HmnTrimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmntrimmer:0.6.5--he93f0d0_1
stdout: hmntrimmer_RenderingReportFile.py.out
