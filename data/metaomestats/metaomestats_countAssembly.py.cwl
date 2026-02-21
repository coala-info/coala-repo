cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaomestats_countAssembly.py
label: metaomestats_countAssembly.py
doc: "A tool from the metaomestats package for counting assembly statistics. (Note:
  The provided help text contains only system error logs and no usage information.)\n
  \nTool homepage: https://github.com/raw-lab/metaome_stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaomestats:0.4--pyh5e36f6f_0
stdout: metaomestats_countAssembly.py.out
