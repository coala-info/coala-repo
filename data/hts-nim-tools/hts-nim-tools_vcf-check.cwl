cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hts-nim-tools
  - vcf-check
label: hts-nim-tools_vcf-check
doc: "The provided help text contains a fatal system error (no space left on device)
  and does not contain the actual usage information or argument definitions for the
  tool. Please provide the correct help output (usually obtained via 'hts-nim-tools
  vcf-check --help') to extract the arguments.\n\nTool homepage: https://github.com/brentp/hts-nim-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hts-nim-tools:0.3.11--hbeb723e_0
stdout: hts-nim-tools_vcf-check.out
