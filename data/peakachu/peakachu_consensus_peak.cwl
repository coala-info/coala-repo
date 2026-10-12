cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakachu
  - consensus_peak
label: peakachu_consensus_peak
doc: "Length of the region around peak centers for plotting consensus peaks\n\nTool
  homepage: https://github.com/tbischler/PEAKachu"
inputs:
  - id: project_folder
    type: Directory
    doc: The project folder made by peakachu window or adaptive.
    inputBinding:
      position: 1
  - id: consensus_length
    type:
      - 'null'
      - int
    doc: Length of the region around peak centers for plotting consensus peaks
    inputBinding:
      position: 102
      prefix: --consensus_length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: project_folder_out
    type: Directory
    doc: The project folder with the files written by the command (consensus peak plots).
    outputBinding:
      glob: $(inputs.project_folder.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project_folder)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
stdout: peakachu_consensus_peak.out
