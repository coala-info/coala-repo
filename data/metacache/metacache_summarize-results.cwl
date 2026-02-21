cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - summarize-results
label: metacache_summarize-results
doc: "Summarize results from MetaCache (Note: The provided help text contains only
  system error logs and no argument definitions).\n\nTool homepage: https://github.com/muellan/metacache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_summarize-results.out
