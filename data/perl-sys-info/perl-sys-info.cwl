cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sys-info
label: perl-sys-info
doc: "A tool for gathering system information. (Note: The provided input text contains
  execution logs and an error message rather than help documentation; therefore, no
  arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Sys::Info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sys-info:0.7811--pl526_0
stdout: perl-sys-info.out
