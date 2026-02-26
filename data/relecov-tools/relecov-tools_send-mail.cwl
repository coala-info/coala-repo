cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - send-mail
label: relecov-tools_send-mail
doc: "Send a sample validation report by mail.\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: additional_notes
    type:
      - 'null'
      - File
    doc: Path to a .txt file with additional notes to include in the email 
      (optional).
    inputBinding:
      position: 101
      prefix: --additional_notes
  - id: attachments
    type:
      - 'null'
      - File
    doc: Path to file
    inputBinding:
      position: 101
      prefix: --attachments
  - id: email_psswd
    type:
      - 'null'
      - string
    doc: Password for bioinformatica@isciii.es
    inputBinding:
      position: 101
      prefix: --email_psswd
  - id: receiver_email
    type:
      - 'null'
      - string
    doc: Recipient's e-mail address (optional). If not provided, it will be 
      extracted from the institutions guide.
    inputBinding:
      position: 101
      prefix: --receiver_email
  - id: template_path
    type:
      - 'null'
      - Directory
    doc: Path to relecov-tools templates folder (optional)
    inputBinding:
      position: 101
      prefix: --template_path
  - id: validate_file
    type: File
    doc: Path to the validation summary json file (validate_log_summary.json)
    inputBinding:
      position: 101
      prefix: --validate_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
stdout: relecov-tools_send-mail.out
