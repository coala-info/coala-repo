cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp_addr2line
label: pp_addr2line
doc: "The provided text appears to be a container runtime error log rather than help
  documentation for the tool 'pp_addr2line'. No command-line arguments or usage information
  could be extracted.\n\nTool homepage: https://github.com/hrydgard/ppsspp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp:1.6.5--py27_0
stdout: pp_addr2line.out
