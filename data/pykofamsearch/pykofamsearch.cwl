cwlVersion: v1.2
class: CommandLineTool
baseCommand: pykofamsearch
label: pykofamsearch
doc: "A tool for searching KOfam (KEGG Ortholog clusters) using HMMER.\n\nTool homepage:
  https://github.com/jolespin/pykofamsearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
stdout: pykofamsearch.out
