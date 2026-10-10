cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - database-report
label: metabuli_database-report
doc: "Generate a taxonomy report of a database.\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
inputs:
  - id: database_directory
    type: Directory
    doc: "Database directory; staged writable because the report is written into it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: taxonomy_path
    type: 
      - 'null'
      - Directory
    doc: "Directory where the taxonomy dump files are stored"
    inputBinding:
      position: 100
      prefix: --taxonomy-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_report
    type: File
    doc: "Taxonomy report of the database (database_report.tsv)"
    outputBinding:
      glob: $(inputs.database_directory.basename)/database_report.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_database-report.out
