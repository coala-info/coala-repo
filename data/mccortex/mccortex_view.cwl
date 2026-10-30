cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - view
label: mccortex_view
doc: "View a cortex graph as a list of k-mers with coverage and edges. The default is --info --check.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: kmers
    type:
      - 'null'
      - boolean
    doc: Print k-mers with coverage and edges.
    inputBinding:
      position: 1
      prefix: --kmers
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check k-mers.
    inputBinding:
      position: 1
      prefix: --check
  - id: info
    type:
      - 'null'
      - boolean
    doc: Print graph header information.
    inputBinding:
      position: 1
      prefix: --info
  - id: graph
    type: File
    doc: Input cortex graph file (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: view_txt
    type: stdout
    doc: Text view of the graph.
stdout: mccortex_view.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
