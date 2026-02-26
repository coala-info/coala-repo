cwlVersion: v1.2
class: CommandLineTool
baseCommand: grzctl consent
label: grzctl_consent
doc: "Check if a submission is consented for research.\n\n  Returns 'true' if consented,
  'false' if not. A submission is considered\n  consented if all donors have consented
  for research, that is the FHIR MII IG\n  Consent profiles all have a \"permit\"\
  \ provision for code\n  2.16.840.1.113883.3.1937.777.24.5.3.8\n\nTool homepage:
  https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: date
    type:
      - 'null'
      - string
    doc: "date for which to check consent validity in ISO\n                      \
      \   format (default: today)"
    default: today
    inputBinding:
      position: 101
      prefix: --date
  - id: details
    type:
      - 'null'
      - boolean
    doc: Show more detailed output.
    inputBinding:
      position: 101
      prefix: --details
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output JSON for machine-readability.
    inputBinding:
      position: 101
      prefix: --json
  - id: submission_dir
    type: Directory
    doc: "Path to the submission directory containing\n                         'metadata/',
      'files/', 'encrypted_files/' and 'logs/'\n                         directories"
    inputBinding:
      position: 101
      prefix: --submission-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_consent.out
