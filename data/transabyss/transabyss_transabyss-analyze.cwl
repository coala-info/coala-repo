cwlVersion: v1.2
class: CommandLineTool
baseCommand: transabyss-analyze
label: transabyss_transabyss-analyze
doc: "Analyze Trans-ABySS assemblies (Note: The provided help text contained only
  system error logs and no usage information).\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transabyss:2.0.1--py27_4
stdout: transabyss_transabyss-analyze.out
