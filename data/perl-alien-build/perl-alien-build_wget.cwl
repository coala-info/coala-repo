cwlVersion: v1.2
class: CommandLineTool
baseCommand: wget
label: perl-alien-build_wget
doc: "Retrieve files via HTTP or FTP\n\nTool homepage: https://metacpan.org/pod/Alien::Build"
inputs:
  - id: urls
    type:
      type: array
      items: string
    doc: URL(s) to retrieve
    inputBinding:
      position: 1
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Continue retrieval of aborted transfer
    inputBinding:
      position: 102
      prefix: -c
  - id: directory_prefix
    type:
      - 'null'
      - Directory
    doc: Save to DIR
    default: .
    inputBinding:
      position: 102
      prefix: -P
  - id: header
    type:
      - 'null'
      - string
    doc: "Add STR (of form 'header: value') to headers"
    inputBinding:
      position: 102
      prefix: --header
  - id: no_check_certificate
    type:
      - 'null'
      - boolean
    doc: Don't validate the server's certificate
    inputBinding:
      position: 102
      prefix: --no-check-certificate
  - id: post_data
    type:
      - 'null'
      - string
    doc: Send STR using POST method
    inputBinding:
      position: 102
      prefix: --post-data
  - id: post_file
    type:
      - 'null'
      - File
    doc: Send FILE using POST method
    inputBinding:
      position: 102
      prefix: --post-file
  - id: proxy
    type:
      - 'null'
      - string
    doc: Use proxy (on/off)
    inputBinding:
      position: 102
      prefix: -Y
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet
    inputBinding:
      position: 102
      prefix: -q
  - id: server_response
    type:
      - 'null'
      - boolean
    doc: Show server response
    inputBinding:
      position: 102
      prefix: -S
  - id: spider
    type:
      - 'null'
      - boolean
    doc: 'Only check URL existence: $? is 0 if exists'
    inputBinding:
      position: 102
      prefix: --spider
  - id: timeout
    type:
      - 'null'
      - int
    doc: Network read timeout is SEC seconds
    inputBinding:
      position: 102
      prefix: -T
  - id: user_agent
    type:
      - 'null'
      - string
    doc: Use STR for User-Agent header
    inputBinding:
      position: 102
      prefix: -U
outputs:
  - id: output_document
    type:
      - 'null'
      - File
    doc: Save to FILE ('-' for stdout)
    outputBinding:
      glob: $(inputs.output_document)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log messages to FILE
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-alien-build:2.84--pl5321h7b50bb2_1
