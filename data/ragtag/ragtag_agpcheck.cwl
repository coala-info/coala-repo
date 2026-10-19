cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - agpcheck
label: ragtag_agpcheck
doc: "Check AGP v2.1 files for validity.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: agp_files
    type:
      type: array
      items: File
    doc: AGP v2.1 files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: check_log
    type: stderr
    doc: Check messages (written to standard error by the tool)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_agpcheck.out
stderr: ragtag_agpcheck.err
