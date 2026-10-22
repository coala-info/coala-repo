cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread-fullscan
label: subread_subread-fullscan
doc: "Scan the entire genome to find all high-similarity locations to a specified read.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: index_basename
    type: string
    doc: Base name of the index.
    inputBinding:
      position: 1
      prefix: -i
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files built by subread-buildindex (staged in the working directory so the base name resolves)
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: "The minimum fraction of matched bases in the read, 0.8 by default."
    inputBinding:
      position: 1
      prefix: -m
  - id: read_string
    type: string
    doc: The read bases.
    inputBinding:
      position: 101
outputs:
  - id: report
    type: stderr
    doc: Scan report (locations found, written by the tool to standard error)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stderr: subread_subread-fullscan.err
