cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - make-report
label: metabuli_make-report
doc: "Generate a Kraken-style taxonomy report using read-by-read classifications.\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
inputs:
  - id: binning_result
    type: File
    doc: "Binning (read-by-read classification) result"
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    doc: "Output directory (created before the run)"
    inputBinding:
      position: 2
  - id: job_id
    type: string
    doc: "Job ID, the prefix of the report file"
    inputBinding:
      position: 3
  - id: taxonomy_dir
    type: Directory
    doc: "Taxonomy dump directory"
    inputBinding:
      position: 4
  - id: readid_col
    type: 
      - 'null'
      - int
    doc: "Column number of accession in classification result [1]"
    inputBinding:
      position: 11
      prefix: --readid-col
  - id: taxid_col
    type: 
      - 'null'
      - int
    doc: "Column number of taxonomy ID in classification result [2]"
    inputBinding:
      position: 12
      prefix: --taxid-col
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: report_dir
    type: Directory
    doc: "Output directory with the report"
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_make-report.out
