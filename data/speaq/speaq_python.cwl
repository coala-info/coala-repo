cwlVersion: v1.2
class: CommandLineTool
baseCommand: speaq_python
label: speaq_python
doc: "A tool for NMR (Nuclear Magnetic Resonance) spectral alignment and quality control.
  (Note: The provided text contains container build logs and error messages rather
  than command-line help documentation.)\n\nTool homepage: https://github.com/mlvlab/SpeaQ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/speaq:phenomenal-v2.3.1_cv1.0.1.13
stdout: speaq_python.out
