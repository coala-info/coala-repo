cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - strucvars
  - ingest
label: varfish-server-worker_strucvars_ingest
doc: 'Ingest structural variant VCF.


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
    doc: Value to write out for `##x-varfish-case-uuid`
    inputBinding:
      position: 102
      prefix: --case-uuid
  - id: genomebuild
    type: string
    doc: The assumed genome build (grch37 or grch38)
    inputBinding:
      position: 102
      prefix: --genomebuild
  - id: path_ped
    type: File
    doc: Path to the pedigree file
    inputBinding:
      position: 102
      prefix: --path-ped
  - id: path_in
    type:
      type: array
      items: File
      inputBinding:
        prefix: --path-in
    doc: Path to input files
    inputBinding:
      position: 102
  - id: path_cov_vcf
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --path-cov-vcf
    doc: Path to coverage VCF files from maelstrom; optional
    inputBinding:
      position: 102
  - id: path_out
    type: string
    doc: Path to output file
    inputBinding:
      position: 102
      prefix: --path-out
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: 'Minimal reciprocal overlap to require [default: 0.8]'
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: slack_bnd
    type:
      - 'null'
      - int
    doc: 'Slack to use around break-ends [default: 50]'
    inputBinding:
      position: 102
      prefix: --slack-bnd
  - id: slack_ins
    type:
      - 'null'
      - int
    doc: 'Slack to use around insertions [default: 50]'
    inputBinding:
      position: 102
      prefix: --slack-ins
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator (UUIDs), if any
    inputBinding:
      position: 102
      prefix: --rng-seed
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
