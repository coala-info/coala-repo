cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair3-trio_run_clair3_trio.sh
label: clair3-trio_run_clair3_trio.sh
doc: "Clair3-Trio variant calling tool (Note: The provided text is an error log and
  does not contain usage information or argument definitions).\n\nTool homepage: https://github.com/HKU-BAL/Clair3-Trio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3-trio:0.7--py39hd649744_2
stdout: clair3-trio_run_clair3_trio.sh.out
