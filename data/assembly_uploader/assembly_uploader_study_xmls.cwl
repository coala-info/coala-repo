cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - study_xmls
label: assembly_uploader_study_xmls
doc: "Study XML generation: write the registration and submission XML files for a\
  \ new ENA assembly study derived from a raw reads study.\n\nTool homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs:
  - id: study
    type: string
    doc: Raw reads study ID
    inputBinding:
      position: 1
      prefix: --study
  - id: library
    type:
      type: enum
      symbols:
        - metagenome
        - metatranscriptome
    doc: Library type
    inputBinding:
      position: 1
      prefix: --library
  - id: center
    type: string
    doc: Center for upload e.g. EMG
    inputBinding:
      position: 1
      prefix: --center
  - id: hold
    type:
      - 'null'
      - string
    doc: Hold date (private) in format dd-mm-yyyy. Will inherit the release date of
      the raw read study if not provided.
    inputBinding:
      position: 1
      prefix: --hold
  - id: tpa
    type:
      - 'null'
      - boolean
    doc: 'Use this flag if the study is a third-party assembly. Default: False'
    inputBinding:
      position: 1
      prefix: --tpa
  - id: publication
    type:
      - 'null'
      - int
    doc: PubMed ID for connected publication if available
    inputBinding:
      position: 1
      prefix: --publication
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
  - id: test
    type:
      - 'null'
      - boolean
    doc: Use flag when submitting to the ENA TEST server (adds a timestamp to the
      study alias)
    inputBinding:
      position: 1
      prefix: --test
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
    doc: The <study>_upload folder with the study XML files.
    outputBinding:
      glob: '${ return (inputs.output_dir ? inputs.output_dir + ''/'' : '''') + inputs.study
        + ''_upload''; }'
  - id: study_xml
    type: File
    doc: Study registration XML (<study>_reg.xml).
    outputBinding:
      glob: '${ return (inputs.output_dir ? inputs.output_dir + ''/'' : '''') + inputs.study
        + ''_upload/'' + inputs.study + ''_reg.xml''; }'
  - id: submission_xml
    type: File
    doc: Submission XML (<study>_submission.xml).
    outputBinding:
      glob: '${ return (inputs.output_dir ? inputs.output_dir + ''/'' : '''') + inputs.study
        + ''_upload/'' + inputs.study + ''_submission.xml''; }'
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
