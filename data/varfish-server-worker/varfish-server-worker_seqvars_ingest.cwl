cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - seqvars
  - ingest
label: varfish-server-worker_seqvars_ingest
doc: 'Ingest sequence variant VCF.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: file_date
    type: string
    doc: Value to write to `##fileDate`
    inputBinding:
      position: 102
      prefix: --file-date
  - id: case_uuid
    type: string
    doc: The case UUID to write out
    inputBinding:
      position: 102
      prefix: --case-uuid
  - id: genomebuild
    type: string
    doc: The assumed genome build (grch37 or grch38)
    inputBinding:
      position: 102
      prefix: --genomebuild
  - id: path_mehari_db
    type: Directory
    doc: The path to the mehari database
    inputBinding:
      position: 102
      prefix: --path-mehari-db
  - id: path_ped
    type: File
    doc: Path to the pedigree file
    inputBinding:
      position: 102
      prefix: --path-ped
  - id: path_in
    type: File
    doc: Path to input file
    inputBinding:
      position: 102
      prefix: --path-in
  - id: path_out
    type: string
    doc: Path to output file
    inputBinding:
      position: 102
      prefix: --path-out
  - id: max_var_count
    type:
      - 'null'
      - int
    doc: Maximal number of variants to write out; optional
    inputBinding:
      position: 102
      prefix: --max-var-count
  - id: id_mapping
    type:
      - 'null'
      - string
    doc: Per-file identifier mapping, either a JSON or @-prefixed path to JSON
    inputBinding:
      position: 102
      prefix: --id-mapping
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Ingested VCF file
    outputBinding:
      glob: $(inputs.path_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
