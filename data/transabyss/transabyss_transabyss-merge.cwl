cwlVersion: v1.2
class: CommandLineTool
baseCommand: transabyss-merge
label: transabyss_transabyss-merge
doc: "The provided text is an error log from a container build process and does not
  contain the help text or usage information for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transabyss:2.0.1--py27_4
stdout: transabyss_transabyss-merge.out
