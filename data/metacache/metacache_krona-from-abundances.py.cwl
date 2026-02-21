cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacache_krona-from-abundances.py
label: metacache_krona-from-abundances.py
doc: "A script to convert MetaCache abundance results to Krona format. (Note: The
  provided help text contained only system error messages and no usage information;
  arguments could not be extracted.)\n\nTool homepage: https://github.com/muellan/metacache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_krona-from-abundances.py.out
