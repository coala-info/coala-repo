cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthofinder_primary_transcript.py
label: orthofinder_primary_transcript.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure.\n\n
  Tool homepage: https://github.com/OrthoFinder/OrthoFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthofinder:3.1.2--hdfd78af_1
stdout: orthofinder_primary_transcript.py.out
