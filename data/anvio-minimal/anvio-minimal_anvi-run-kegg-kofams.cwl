cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-run-kegg-kofams
label: anvio-minimal_anvi-run-kegg-kofams
doc: "Run KofamScan on an anvi'o contigs database. Note: The provided help text appears
  to be a container execution error (no space left on device) and does not contain
  usage information or argument definitions.\n\nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-run-kegg-kofams.out
