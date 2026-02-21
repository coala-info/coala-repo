cwlVersion: v1.2
class: CommandLineTool
baseCommand: verse
label: verse_agentverse-benchmark
doc: "The provided text appears to be a container build error log rather than CLI
  help text. No arguments or usage information could be extracted from the input.\n
  \nTool homepage: https://github.com/OpenBMB/AgentVerse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verse:0.1.5--h577a1d6_9
stdout: verse_agentverse-benchmark.out
