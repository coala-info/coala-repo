cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gogstools
  - gff2embl
label: gogstools_gff2embl
doc: "Convert GFF files to EMBL format. (Note: The provided help text contains only
  container runtime error messages and no usage information; arguments could not be
  extracted from the source text.)\n\nTool homepage: https://github.com/genouest/ogs-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
stdout: gogstools_gff2embl.out
