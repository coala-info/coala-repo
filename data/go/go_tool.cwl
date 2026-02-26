cwlVersion: v1.2
class: CommandLineTool
baseCommand: go
label: go_tool
doc: "A collection of tools for Go development.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: tool
    type: string
    doc: The Go tool to run (e.g., addr2line, api, asm, buildid, cgo, compile, 
      cover, dist, doc, fix, link, nm, objdump, pack, pprof, test2json, trace, 
      vet).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_tool.out
