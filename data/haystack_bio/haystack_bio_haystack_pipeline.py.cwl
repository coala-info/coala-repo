cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_bio_haystack_pipeline.py
label: haystack_bio_haystack_pipeline.py
doc: "Haystack pipeline for epigenetic analysis (Note: The provided text contains
  system error logs rather than help documentation).\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_pipeline.py.out
