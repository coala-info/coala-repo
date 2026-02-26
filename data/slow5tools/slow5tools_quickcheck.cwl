cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - quickcheck
label: slow5tools_quickcheck
doc: "Performs a quick check if a SLOW5/BLOW5 file is intact. That is, quickcheck
  checks if the file begins with a valid header (SLOW5 or BLOW5), attempt to decode
  the first SLOW5 record and then seeks to the end of the file and checks if proper
  EOF exists (BLOW5 only).If the file is intact, the commands exists with 0. Otherwise
  exists with a non-zero error code.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: Path to the SLOW5/BLOW5 file to check
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools_quickcheck.out
