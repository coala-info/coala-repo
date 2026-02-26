cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_01_run_genomad_checkv
label: mvip_MVP_01_run_genomad_checkv
doc: "Run geNomad and CheckV.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: checkv_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the CheckV database directory.
    inputBinding:
      position: 101
      prefix: --checkv_db_path
  - id: force_checkv
    type:
      - 'null'
      - boolean
    doc: Run CheckV even if output already exists.
    inputBinding:
      position: 101
      prefix: --force_checkv
  - id: force_genomad
    type:
      - 'null'
      - boolean
    doc: Run geNomad even if output already exists.
    inputBinding:
      position: 101
      prefix: --force_genomad
  - id: genomad_conservative
    type:
      - 'null'
      - boolean
    doc: Run geNomad with conservative filtering.
    inputBinding:
      position: 101
      prefix: --genomad_conservative
  - id: genomad_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the geNomad database directory.
    inputBinding:
      position: 101
      prefix: --genomad_db_path
  - id: genomad_relaxed
    type:
      - 'null'
      - boolean
    doc: Run geNomad with relaxed filtering.
    inputBinding:
      position: 101
      prefix: --genomad_relaxed
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_seq_size
    type:
      - 'null'
      - int
    doc: Minimum sequence size to keep (in base pairs).
    inputBinding:
      position: 101
      prefix: --min_seq_size
  - id: sample_group
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specific sample number(s) to run the script on (can be a comma-separated
      list: 1,2,6 for example). By default, MVP processes all datasets listed in the
      metadata file one after the other.'
    inputBinding:
      position: 101
      prefix: --sample_group
  - id: skip_modify_assemblies
    type:
      - 'null'
      - boolean
    doc: Modify sequence headers by adding sample name, False by default.
    default: false
    inputBinding:
      position: 101
      prefix: --skip_modify_assemblies
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = 1)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_01_run_genomad_checkv.out
