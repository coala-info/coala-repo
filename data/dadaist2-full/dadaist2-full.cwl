cwlVersion: v1.2
class: CommandLineTool
baseCommand: dadaist2-full
label: dadaist2-full
doc: The provided text does not contain help information or a description of the tool;
  it contains system log messages and a fatal error regarding a container build failure
  (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dadaist2-full:2.0--hdfd78af_0
stdout: dadaist2-full.out
