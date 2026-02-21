cwlVersion: v1.2
class: CommandLineTool
baseCommand: vadr_v-annotate.pl
label: vadr_v-annotate.pl
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build/execution attempt.\n\nTool homepage: https://github.com/ncbi/vadr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_v-annotate.pl.out
