cwlVersion: v1.2
class: CommandLineTool
baseCommand: e-pcr
label: e-pcr
doc: "Electronic PCR (e-PCR) is a tool to search for sequence tagged sites (STSs)
  in DNA sequences.\n\nTool homepage: https://github.com/joddie/pcre2el"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/e-pcr:2.3.12--0
stdout: e-pcr.out
