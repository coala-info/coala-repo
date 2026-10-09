cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-biom
label: kraken-biom
doc: "Create BIOM-format tables (http://biom-format.org) from Kraken output\n\nTool
  homepage: https://github.com/smdabdoub/kraken-biom"
inputs:
  - id: kraken_reports
    type:
      - 'null'
      - type: array
        items: File
    doc: Results files from the kraken-report tool. Sample IDs are taken from the
      file names (everything up to the first dot)
    inputBinding:
      position: 200
  - id: kraken_reports_fp
    type:
      - 'null'
      - Directory
    doc: Folder containing kraken reports
    inputBinding:
      position: 1
      prefix: -k
  - id: max
    type:
      - 'null'
      - string
    doc: Assigned reads will be recorded only if they are at or below max rank
      (D, P, C, O, F, G, S or SS; default O)
    inputBinding:
      position: 2
      prefix: --max
  - id: min
    type:
      - 'null'
      - string
    doc: Reads assigned at and below min rank will be recorded as being assigned
      to the min rank level (D, P, C, O, F, G, S or SS; default S)
    inputBinding:
      position: 3
      prefix: --min
  - id: output_fp
    type: string
    doc: Path to the BIOM-format file (default ./table.biom)
    inputBinding:
      position: 4
      prefix: -o
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to the sample metadata file in TSV format. The first column is the
      Sample ID
    inputBinding:
      position: 5
      prefix: --metadata
  - id: otu_fp
    type:
      - 'null'
      - string
    doc: Create a file containing just the (NCBI) OTU IDs
    inputBinding:
      position: 6
      prefix: --otu_fp
  - id: fmt
    type:
      - 'null'
      - string
    doc: Set the output format of the BIOM table (hdf5, json or tsv; default
      hdf5)
    inputBinding:
      position: 7
      prefix: --fmt
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress the output BIOM table with gzip (not needed for hdf5)
    inputBinding:
      position: 8
      prefix: --gzip
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints status messages during program execution
    inputBinding:
      position: 9
      prefix: --verbose
outputs:
  - id: biom_table
    type:
      - 'null'
      - File
    doc: BIOM table (with .gz added when --gzip is used)
    outputBinding:
      glob: $(inputs.output_fp)*
  - id: otu_ids
    type:
      - 'null'
      - File
    doc: File with the OTU IDs
    outputBinding:
      glob: $(inputs.otu_fp)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken-biom:1.2.0--pyh5e36f6f_0
