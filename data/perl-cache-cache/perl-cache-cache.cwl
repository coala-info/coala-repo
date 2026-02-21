cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cache-cache
label: perl-cache-cache
doc: "The provided text is an error log indicating that the executable 'perl-cache-cache'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: http://metacpan.org/pod/Cache::Cache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cache-cache:1.08--pl526_0
stdout: perl-cache-cache.out
