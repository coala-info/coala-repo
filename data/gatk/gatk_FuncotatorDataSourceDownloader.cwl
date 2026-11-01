cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FuncotatorDataSourceDownloader
label: gatk_FuncotatorDataSourceDownloader
doc: |-
  Download the Broad Institute pre-packaged data sources for the somatic or germline use case for Funcotator.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: extract_after_download
  type:
  - 'null'
  - boolean
  doc: 'Extract the data sources to a sibling folder after they have been downloaded.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --extract-after-download
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: germline
  type:
  - 'null'
  - boolean
  doc: 'Download the latest pre-packaged datasources for germline functional annotation.
    Default value: false. Possible values: {true, false} Cannot be used in conjunction
    with argument(s) getSomaticDataSources (somatic) testingOverrideDataSourcesSha256Path
    (testing-override-path-for-datasources-sha256) testingOverrideDataSourcesPath
    (testing-override-path-for-datasources)'
  inputBinding:
    prefix: --germline
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: hg19
  type:
  - 'null'
  - boolean
  doc: 'If set, will extract data from the HG19 data sources bucket. Default value:
    false. Possible values: {true, false} Cannot be used in conjunction with argument(s)
    getHg38Datasources (hg38) testingOverrideDataSourcesSha256Path (testing-override-path-for-datasources-sha256)'
  inputBinding:
    prefix: --hg19
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: hg38
  type:
  - 'null'
  - boolean
  doc: 'If set, will extract data from the HG38 data sources bucket. Default value:
    false. Possible values: {true, false} Cannot be used in conjunction with argument(s)
    getHg19Datasources (hg19) testingOverrideDataSourcesSha256Path (testing-override-path-for-datasources-sha256)'
  inputBinding:
    prefix: --hg38
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: output
  type:
  - 'null'
  - string
  doc: Output location for the data sources.
  inputBinding:
    prefix: --output
- id: overwrite_output_file
  type:
  - 'null'
  - boolean
  doc: 'Overwrite output file if it exists already. Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --overwrite-output-file
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: somatic
  type:
  - 'null'
  - boolean
  doc: 'Download the latest pre-packaged datasources for somatic functional annotation.
    Default value: false. Possible values: {true, false} Cannot be used in conjunction
    with argument(s) getGermlineDataSources (germline) testingOverrideDataSourcesSha256Path
    (testing-override-path-for-datasources-sha256) testingOverrideDataSourcesPath
    (testing-override-path-for-datasources)'
  inputBinding:
    prefix: --somatic
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: validate_integrity
  type:
  - 'null'
  - boolean
  doc: 'Validate the integrity of the data sources after downloading them using sha256.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --validate-integrity
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_output
  type:
  - 'null'
  - File
  doc: Output location for the data sources.
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
