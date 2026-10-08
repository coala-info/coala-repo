cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - emmtyper-db
label: emmtyper_emmtyper-db
doc: "Update the EMM database used by emmtyper. EMAIL is needed to connect to the
  CDC FTP server.\n\nTool homepage: https://github.com/MDUPHL/emmtyper"
inputs:
  - id: email
    type: string
    doc: EMAIL is needed to connect to CDC FTP server (used as the anonymous FTP
      password).
    inputBinding:
      position: 2
  - id: db_folder
    type: Directory
    doc: Existing EMM database folder to update (must contain db_metadata.json).
      It is staged writable and the updated copy is returned.
    inputBinding:
      position: 1
      prefix: --db_folder
      valueFrom: $(self.basename)
outputs:
  - id: updated_db_folder
    type: Directory
    doc: Updated EMM database folder
    outputBinding:
      glob: $(inputs.db_folder.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db_folder)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: EMM_DB
        envValue: $(runtime.outdir)/$(inputs.db_folder.basename)
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emmtyper:0.2.0--py_0
stdout: emmtyper-db.out
