cwlVersion: v1.2
class: CommandLineTool
baseCommand: vadr_v-test.pl
label: vadr_v-test.pl
doc: "A test script for the VADR (Viral Annotation DefineR) tool suite. Note: The
  provided text contains system logs and a fatal error regarding container image retrieval
  rather than command-line help documentation.\n\nTool homepage: https://github.com/ncbi/vadr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_v-test.pl.out
