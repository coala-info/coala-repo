cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sam2lca
label: sam2lca_list-db
doc: "List available taxonomy and acc2tax databases\n\nTool homepage: https://github.com/maxibor/sam2lca"
arguments:
  - position: 2
    valueFrom: list-db
inputs:
  - id: dbdir
    type: Directory
    doc: Directory with the taxonomy and acc2tax databases (global option --dbdir)
    inputBinding:
      position: 1
      prefix: --dbdir
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (the tool logs the database list here)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
stdout: sam2lca_list-db.out
stderr: sam2lca_list-db.err
