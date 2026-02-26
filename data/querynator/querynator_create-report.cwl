cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - querynator
  - create-report
label: querynator_create-report
doc: "Generates reports from CGI and CIViC result folders.\n\nTool homepage: https://github.com/qbic-pipelines/querynator"
inputs:
  - id: cgi_path
    type: Directory
    doc: Path to a CGI result folder generated using the querynator
    inputBinding:
      position: 101
      prefix: --cgi_path
  - id: civic_path
    type: Directory
    doc: Path to a CIViC result folder generated using the querynator
    inputBinding:
      position: 101
      prefix: --civic_path
  - id: outdir
    type: string
    doc: Name of new directory in which reports will be stored.
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
stdout: querynator_create-report.out
