cwlVersion: v1.2
class: CommandLineTool
baseCommand: fio
label: fiona_fio
doc: "Fiona command line interface.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: aws_no_sign_requests
    type:
      - 'null'
      - boolean
    doc: Make requests anonymously
    inputBinding:
      position: 103
      prefix: --aws-no-sign-requests
  - id: aws_profile
    type:
      - 'null'
      - string
    doc: Select a profile from the AWS credentials file
    inputBinding:
      position: 103
      prefix: --aws-profile
  - id: aws_requester_pays
    type:
      - 'null'
      - boolean
    doc: Requester pays data transfer costs
    inputBinding:
      position: 103
      prefix: --aws-requester-pays
  - id: gdal_version
    type:
      - 'null'
      - boolean
    doc: Show the version and exit.
    inputBinding:
      position: 103
      prefix: --gdal-version
  - id: python_version
    type:
      - 'null'
      - boolean
    doc: Show the version and exit.
    inputBinding:
      position: 103
      prefix: --python-version
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio.out
