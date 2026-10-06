cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly_manifest
label: assembly_uploader_assembly_manifest
doc: "Generate manifests for assembly uploads.\n\nTool homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs:
  - id: study
    type: string
    doc: Raw reads study ID (used as a label for the upload directory)
    inputBinding:
      position: 1
      prefix: --study
  - id: data
    type:
      - 'null'
      - File
    doc: Metadata CSV - runs, coverage, assembler, version, filepath, and optionally
      sample
    inputBinding:
      position: 1
      prefix: --data
  - id: assembly_study
    type:
      - 'null'
      - string
    doc: Pre-existing study ID to submit to if available. Must exist in the webin
      account.
    inputBinding:
      position: 1
      prefix: --assembly_study
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite all existing manifests
    inputBinding:
      position: 1
      prefix: --force
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Path to output directory
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: private
    type:
      - 'null'
      - boolean
    doc: Use flag if private
    inputBinding:
      position: 1
      prefix: --private
  - id: tpa
    type:
      - 'null'
      - boolean
    doc: 'Use this flag if the study is a third-party assembly. Default: False'
    inputBinding:
      position: 1
      prefix: --tpa
  - id: test
    type:
      - 'null'
      - boolean
    doc: Use flag when submitting to the ENA TEST server (adds a timestamp to the
      assembly alias)
    inputBinding:
      position: 1
      prefix: --test
  - id: assemblies
    type:
      - 'null'
      - type: array
        items: File
    doc: Gzipped assembly FASTA files named in the Filepath column of the CSV; they
      are staged in the working directory, so give their file names (no folders) in
      the CSV.
  - id: ena_webin
    type:
      - 'null'
      - string
    doc: ENA Webin account name (set as the ENA_WEBIN environment variable); needed
      only with --private
  - id: ena_webin_password
    type:
      - 'null'
      - string
    doc: ENA Webin password (set as the ENA_WEBIN_PASSWORD environment variable);
      needed only with --private
outputs:
  - id: upload_dir
    type: Directory
    doc: The <study>_upload folder with the manifest files.
    outputBinding:
      glob: '${ return (inputs.output_dir ? inputs.output_dir + ''/'' : '''') + inputs.study
        + ''_upload''; }'
  - id: manifests
    type: File[]
    doc: Assembly manifest files (<md5 prefix>.manifest).
    outputBinding:
      glob: '${ return (inputs.output_dir ? inputs.output_dir + ''/'' : '''') + inputs.study
        + ''_upload/*.manifest''; }'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: ENA_WEBIN
        envValue: '${ return inputs.ena_webin === null ? "" : inputs.ena_webin; }'
      - envName: ENA_WEBIN_PASSWORD
        envValue: '${ return inputs.ena_webin_password === null ? "" : inputs.ena_webin_password;
          }'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.assemblies)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
