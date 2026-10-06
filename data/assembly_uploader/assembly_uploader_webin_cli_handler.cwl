cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - webin_cli_handler
label: assembly_uploader_webin_cli_handler
doc: "Validate or submit an ENA manifest (e.g. an assembly manifest from assembly_manifest)\
  \ with ENA Webin-CLI (script from mgnify-pipelines-toolkit, recommended by assembly_uploader\
  \ for the upload step).\n\nTool homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs:
  - id: manifest
    type: File
    doc: Manifest text file containing file and metadata fields
    inputBinding:
      position: 1
      prefix: --manifest
  - id: context
    type:
      type: enum
      symbols:
        - genome
        - transcriptome
        - sequence
        - polysample
        - reads
        - taxrefset
    doc: 'Submission type: genome, transcriptome, sequence, polysample, reads, taxrefset'
    inputBinding:
      position: 1
      prefix: --context
  - id: mode
    type:
      type: enum
      symbols:
        - submit
        - validate
    doc: submit or validate
    inputBinding:
      position: 1
      prefix: --mode
  - id: test
    type:
      - 'null'
      - boolean
    doc: Specify to use test server instead of live
    inputBinding:
      position: 1
      prefix: --test
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Path to working directory (folder that holds the files named in the manifest)
    inputBinding:
      position: 1
      prefix: --workdir
  - id: download_webin_cli
    type:
      - 'null'
      - boolean
    doc: Specify if you do not have ena-webin-cli installed
    inputBinding:
      position: 1
      prefix: --download-webin-cli
  - id: download_webin_cli_directory
    type:
      - 'null'
      - string
    doc: Path to save webin-cli into
    inputBinding:
      position: 1
      prefix: --download-webin-cli-directory
  - id: download_webin_cli_version
    type:
      - 'null'
      - string
    doc: 'Version of ena-webin-cli to download, default: latest'
    inputBinding:
      position: 1
      prefix: --download-webin-cli-version
  - id: webin_cli_jar
    type:
      - 'null'
      - File
    doc: Path to pre-downloaded webin-cli.jar file to execute
    inputBinding:
      position: 1
      prefix: --webin-cli-jar
  - id: retries
    type:
      - 'null'
      - int
    doc: 'Number of retry attempts (default: 3)'
    inputBinding:
      position: 1
      prefix: --retries
  - id: retry_delay
    type:
      - 'null'
      - int
    doc: 'Initial retry delay in seconds (default: 5)'
    inputBinding:
      position: 1
      prefix: --retry-delay
  - id: java_heap_size_initial
    type:
      - 'null'
      - int
    doc: 'Java initial heap size in GB (default: 10)'
    inputBinding:
      position: 1
      prefix: --java-heap-size-initial
  - id: java_heap_size_max
    type:
      - 'null'
      - int
    doc: 'Java maximum heap size in GB (default: 10)'
    inputBinding:
      position: 1
      prefix: --java-heap-size-max
  - id: ena_webin
    type: string
    doc: ENA Webin account name (set as the ENA_WEBIN environment variable)
  - id: ena_webin_password
    type: string
    doc: ENA Webin password (set as the ENA_WEBIN_PASSWORD environment variable)
outputs:
  - id: log
    type: stdout
    doc: webin_cli_handler log.
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: ENA_WEBIN
        envValue: $(inputs.ena_webin)
      - envName: ENA_WEBIN_PASSWORD
        envValue: $(inputs.ena_webin_password)
stdout: webin_cli_handler.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
