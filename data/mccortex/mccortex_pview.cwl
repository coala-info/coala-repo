cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - pview
label: mccortex_pview
doc: "View cortex link files (.ctp) as text.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory to use (for example 1GB).
    inputBinding:
      position: 1
      prefix: --memory
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M).
    inputBinding:
      position: 1
      prefix: --nkmers
  - id: paths
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --paths
    doc: Link file (.ctp or .ctp.gz) to view. Can be given multiple times.
    inputBinding:
      position: 1
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx).
    inputBinding:
      position: 100
outputs:
  - id: pview_txt
    type: stdout
    doc: Text view of the links.
stdout: mccortex_pview.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
