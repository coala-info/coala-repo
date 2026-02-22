cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-importer
label: perl-importer
doc: "The provided text appears to be a system error log (Singularity/OCI conversion
  failure due to insufficient disk space) rather than command-line help text. As a
  result, no functional description or arguments could be extracted.\n\nTool homepage:
  http://metacpan.org/pod/Importer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-importer:0.026--pl5321hdfd78af_0
stdout: perl-importer.out
