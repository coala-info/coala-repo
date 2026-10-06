cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - release_study
label: assembly_uploader_release_study
doc: "Release a private/held study on ENA, e.g. an uploaded assembly study.\n\nTool\
  \ homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs:
  - id: study
    type: string
    doc: Study ID
    inputBinding:
      position: 1
      prefix: --study
  - id: xml_path
    type:
      - 'null'
      - string
    doc: Path to use for the release XML submission
    inputBinding:
      position: 1
      prefix: --xml_path
  - id: test
    type:
      - 'null'
      - boolean
    doc: Use Webin Dev dropbox instead of prod
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
  - id: release_xml
    type:
      - 'null'
      - File
    doc: The release XML submission, when --xml_path is given.
    outputBinding:
      glob: $(inputs.xml_path)
  - id: log
    type: stdout
    doc: Release log.
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: ENA_WEBIN
        envValue: $(inputs.ena_webin)
      - envName: ENA_WEBIN_PASSWORD
        envValue: $(inputs.ena_webin_password)
stdout: release_study.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
