cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_run_test
label: haystack_bio_haystack_run_test
doc: "A command from the haystack_bio suite. (Note: The provided text is an error
  log indicating a system failure and does not contain usage information or argument
  definitions.)\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_run_test.out
