cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - microhapdb
  - summarize
label: microhapdb_summarize
doc: "Summarize MicroHapDB database contents\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs: []
outputs:
  - id: result
    type: stdout
    doc: Database summary (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb_summarize.out
