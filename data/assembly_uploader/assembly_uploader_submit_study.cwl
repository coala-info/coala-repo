cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - submit_study
label: assembly_uploader_submit_study
doc: "Study submission: register the assembly study XMLs (made by study_xmls) with\
  \ ENA.\n\nTool homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs:
  - id: study
    type: string
    doc: raw reads study ID
    inputBinding:
      position: 1
      prefix: --study
  - id: directory
    type: Directory
    doc: directory containing study XML
    inputBinding:
      position: 1
      prefix: --directory
  - id: test
    type:
      - 'null'
      - boolean
    doc: run test submission only
    inputBinding:
      position: 1
      prefix: --test
  - id: ena_webin
    type: string
    doc: ENA Webin account name (set as the ENA_WEBIN environment variable)
  - id: ena_webin_password
    type: string
    doc: ENA Webin password (set as the ENA_WEBIN_PASSWORD environment variable)
outputs:
  - id: log
    type: stdout
    doc: Submission log with the new study accession.
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: ENA_WEBIN
        envValue: $(inputs.ena_webin)
      - envName: ENA_WEBIN_PASSWORD
        envValue: $(inputs.ena_webin_password)
stdout: submit_study.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
