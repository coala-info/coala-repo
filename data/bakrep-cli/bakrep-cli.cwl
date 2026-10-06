cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakrep
  - download
label: bakrep-cli
doc: "Download BakRep datasets (Bakta annotations, CheckM2, GTDB-Tk, assembly-scan
  and MLST results) by dataset id.\n\nTool homepage: https://github.com/ag-computational-bio/bakrep-cli"
inputs:
  - id: tsv
    type:
      - 'null'
      - File
    doc: A tsv with the datasets ids to download. The dataset ids are extracted from
      the first column.
    inputBinding:
      position: 101
      prefix: --tsv
  - id: entries
    type:
      - 'null'
      - string
    doc: Comma separated list of dataset ids to download
    inputBinding:
      position: 101
      prefix: --entries
  - id: directory
    type: string
    default: bakrep_download
    doc: The target directory for the datasets
    inputBinding:
      position: 102
      prefix: --directory
  - id: flat
    type:
      - 'null'
      - boolean
    doc: Save all datasets to the download directory without any group directories
    inputBinding:
      position: 102
      prefix: --flat
  - id: filters
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --match
    doc: "Only download result files that match the attribute-filter, e.g. 'tool:bakta,filetype:gff3'.
      Known attributes: tool:bakta|checkm2|gtdbtk|assemblyscan, filetype:json|ffn|faa|gff3|gbff,
      type: qc|annotation|taxonomy"
    inputBinding:
      position: 102
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Do not resume previous download, but download everything again.
    inputBinding:
      position: 102
      prefix: --restart
outputs:
  - id: outdir
    type: Directory
    doc: Downloaded datasets
    outputBinding:
      glob: $(inputs.directory)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakrep-cli:1.1.0--pyhdfd78af_0
