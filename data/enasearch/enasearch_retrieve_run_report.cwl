cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch retrieve_run_report
label: enasearch_retrieve_run_report
doc: "Retrieve run report from ENA.\n\nThe output can be redirected to a file and
  directly display to the\nstandard output given the display chosen.\n\nTool homepage:
  http://bebatut.fr/enasearch/"
inputs:
  - id: accession
    type: string
    doc: "Accession id (study accessions (ERP, SRP, DRP, PRJ\n                   \
      \ prefixes), experiment accessions (ERX, SRX, DRX prefixes),\n             \
      \       sample accessions (ERS, SRS, DRS, SAM prefixes) and run\n          \
      \          accessions))"
    inputBinding:
      position: 101
      prefix: --accession
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: "Fields to return (accessible with get_run_fields)\n                    [multiple
      or comma-separated]"
    inputBinding:
      position: 101
      prefix: --fields
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: File to save the report
    outputBinding:
      glob: $(inputs.file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
