cwlVersion: v1.2
class: CommandLineTool
baseCommand: wget
label: wget
doc: "The non-interactive network downloader.\n\nTool homepage: https://github.com/rockdaboot/wget2"
inputs:
  - id: urls
    type:
      type: array
      items: string
    doc: The URLs to download
    inputBinding:
      position: 1
  - id: background
    type:
      - 'null'
      - boolean
    doc: Go to background after startup
    inputBinding:
      position: 102
      prefix: --background
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Resume getting a partially-downloaded file
    inputBinding:
      position: 102
      prefix: --continue
  - id: input_file
    type:
      - 'null'
      - File
    doc: Download URLs found in local or external FILE
    inputBinding:
      position: 102
      prefix: --input-file
  - id: limit_rate
    type:
      - 'null'
      - string
    doc: Limit download rate to RATE
    inputBinding:
      position: 102
      prefix: --limit-rate
  - id: no_check_certificate
    type:
      - 'null'
      - boolean
    doc: Don't validate the server's certificate
    inputBinding:
      position: 102
      prefix: --no-check-certificate
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: Skip downloads that would download to existing files
    inputBinding:
      position: 102
      prefix: --no-clobber
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet (no output)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: timeout
    type:
      - 'null'
      - int
    doc: Set all timeout values to SECONDS
    inputBinding:
      position: 102
      prefix: --timeout
  - id: timestamping
    type:
      - 'null'
      - boolean
    doc: Don't re-retrieve files unless newer than local
    inputBinding:
      position: 102
      prefix: --timestamping
  - id: user_agent
    type:
      - 'null'
      - string
    doc: Identify as AGENT instead of Wget/VERSION
    inputBinding:
      position: 102
      prefix: --user-agent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose (this is the default)
    inputBinding:
      position: 102
      prefix: --verbose
  - id: wait
    type:
      - 'null'
      - int
    doc: Wait SECONDS between retrievals
    inputBinding:
      position: 102
      prefix: --wait
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Log messages to FILE
    outputBinding:
      glob: $(inputs.output_file)
  - id: append_output
    type:
      - 'null'
      - File
    doc: Append messages to FILE
    outputBinding:
      glob: $(inputs.append_output)
  - id: output_document
    type:
      - 'null'
      - File
    doc: Write documents to FILE
    outputBinding:
      glob: $(inputs.output_document)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wget:1.25.0
