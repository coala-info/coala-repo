cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - konezumiaid
  - batch
label: konezumiaid_batch
doc: "\nTool homepage: https://github.com/aki2274/KOnezumi-AID"
inputs:
  - id: file
    type: File
    doc: Path to the gene CSV or Excel file (one gene symbol or transcript name per row, no header)
    inputBinding:
      position: 101
      prefix: --file
  - id: konezumiaid_data
    type: Directory
    doc: Dataset folder made by konezumiaid preprocess (staged as konezumiaid_data)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gRNA_output
    type:
      - 'null'
      - Directory
    doc: Folder with the gRNA tables in CSV format (one pair of files per gene)
    outputBinding:
      glob: konezumiaid_data/output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.konezumiaid_data)
        entryname: konezumiaid_data
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
stdout: konezumiaid_batch.out
