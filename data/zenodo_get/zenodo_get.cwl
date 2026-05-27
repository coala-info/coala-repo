cwlVersion: v1.2
class: CommandLineTool
baseCommand: zenodo_get
label: zenodo_get
doc: Command-line interface for downloading files from Zenodo records.
inputs:
  - id: record_or_doi
    type:
      - 'null'
      - string
    doc: Zenodo record ID or DOI
    inputBinding:
      position: 1
  - id: cite
    type:
      - 'null'
      - boolean
    doc: print citation information
    inputBinding:
      position: 102
      prefix: --cite
  - id: record
    type:
      - 'null'
      - string
    doc: Zenodo record ID
    inputBinding:
      position: 102
      prefix: --record
  - id: doi
    type:
      - 'null'
      - string
    doc: Zenodo DOI
    inputBinding:
      position: 102
      prefix: --doi
  - id: md5
    type:
      - 'null'
      - boolean
    doc: Create md5sums.txt for verification.
    inputBinding:
      position: 102
      prefix: --md5
  - id: wget
    type: string
    doc: Create URL list for download managers. (Files will not be downloaded.)
    inputBinding:
      position: 102
      prefix: --wget
  - id: continue_on_error
    type:
      - 'null'
      - boolean
    doc: Continue with next file if error happens.
    inputBinding:
      position: 102
      prefix: --continue-on-error
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'Keep files with invalid checksum. (Default: delete them.)'
    inputBinding:
      position: 102
      prefix: --keep
  - id: do_not_continue
    type:
      - 'null'
      - boolean
    doc: Do not continue previous download attempt, start fresh.
    inputBinding:
      position: 102
      prefix: --do-not-continue
  - id: retry
    type:
      - 'null'
      - int
    doc: Application-level retries for checksum failures and non-HTTP errors.
    inputBinding:
      position: 102
      prefix: --retry
  - id: pause
    type:
      - 'null'
      - float
    doc: Wait N second before retry attempt, e.g. 0.5
    inputBinding:
      position: 102
      prefix: --pause
  - id: time_out
    type:
      - 'null'
      - float
    doc: 'Set connection time-out. Default: 25 [sec].'
    inputBinding:
      position: 102
      prefix: --time-out
  - id: output_dir
    type: string
    doc: 'Output directory, created if necessary. Default: current directory.'
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: sandbox
    type:
      - 'null'
      - boolean
    doc: Use Zenodo Sandbox URL.
    inputBinding:
      position: 102
      prefix: --sandbox
  - id: access_token
    type:
      - 'null'
      - string
    doc: Optional access token for the requests query.
    inputBinding:
      position: 102
      prefix: --access-token
  - id: glob
    type:
      - 'null'
      - type: array
        items: string
    doc: "Glob expressions for files, it can be used multiple times. (e.g., -g '*.txt'
      -g '*.pdf'). Default: all files."
    inputBinding:
      position: 102
      prefix: --glob
  - id: max_http_retries
    type:
      - 'null'
      - int
    doc: HTTP transport-level retries for network errors and 429/5xx responses.
    inputBinding:
      position: 102
      prefix: --max-http-retries
  - id: backoff_factor
    type:
      - 'null'
      - float
    doc: Exponential backoff factor for HTTP retries (e.g., 0.5 means 0.5s, 1s, 
      2s...).
    inputBinding:
      position: 102
      prefix: --backoff-factor
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Re-download and overwrite existing files with mismatched checksums. 
      (Default behavior)
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Do not overwrite existing files with mismatched checksums. Exit with 
      error at end.
    inputBinding:
      position: 102
      prefix: --no-overwrite
  - id: ignore_existing_files
    type:
      - 'null'
      - boolean
    doc: Ignore existing files with mismatched checksums. Do not overwrite, no 
      error.
    inputBinding:
      position: 102
      prefix: --ignore-existing-files
outputs:
  - id: output_wget
    type:
      - 'null'
      - File
    doc: Create URL list for download managers. (Files will not be downloaded.)
    outputBinding:
      glob: $(inputs.wget)
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory, created if necessary. Default: current directory.'
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: hubentu/zenodo-get
s:url: https://github.com/dvolgyes/zenodo_get
$namespaces:
  s: https://schema.org/
