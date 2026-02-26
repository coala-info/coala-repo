cwlVersion: v1.2
class: CommandLineTool
baseCommand: index_default_ssu_rrna_db.py
label: matam_index_default_ssu_rrna_db.py
doc: "Index default SSU rRNA DB\n\nTool homepage: https://github.com/bonsai-team/matam"
inputs:
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory to use (in MBi).
    default: 10000 MBi
    inputBinding:
      position: 101
      prefix: --max_memory
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: Output dir.
    default: $MATAM_DIR/db/
    inputBinding:
      position: 101
      prefix: --ref_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
stdout: matam_index_default_ssu_rrna_db.py.out
