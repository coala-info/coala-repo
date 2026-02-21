cwlVersion: v1.2
class: CommandLineTool
baseCommand: matam_index_default_ssu_rrna_db.py
label: matam_index_default_ssu_rrna_db.py
doc: "Index the default SSU rRNA database for MATAM. (Note: The provided help text
  contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/bonsai-team/matam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
stdout: matam_index_default_ssu_rrna_db.py.out
