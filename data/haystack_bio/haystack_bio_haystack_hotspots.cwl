cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_hotspots
label: haystack_bio_haystack_hotspots
doc: "Haystack hotspots detection tool. (Note: The provided text is a system error
  message regarding container execution and does not contain help documentation or
  argument definitions.)\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_hotspots.out
