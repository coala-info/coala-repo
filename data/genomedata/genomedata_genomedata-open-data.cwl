cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-open-data
label: genomedata_genomedata-open-data
doc: "Open one or more tracks in the specified Genomedata archive.\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: gdarchive
    type: Directory
    doc: "genomedata archive (directory mode). It is copied to the working directory and modified there."
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: tracknames
    type:
      type: array
      items: string
    doc: tracknames to open
    inputBinding:
      position: 2
      prefix: --tracknames
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print status updates and diagnostic messages
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: archive
    type: Directory
    doc: The modified Genomedata archive
    outputBinding:
      glob: $(inputs.gdarchive.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gdarchive)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-open-data.out
