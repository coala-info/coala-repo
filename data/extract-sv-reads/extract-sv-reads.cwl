cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-sv-reads
label: extract-sv-reads
doc: "A tool to extract reads supporting structural variants (SVs). Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/hall-lab/extract_sv_reads"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-sv-reads:1.3.0--pl5321h9948957_6
stdout: extract-sv-reads.out
