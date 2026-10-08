cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-load-data
label: genomedata_genomedata-load-data
doc: "Load data into genomedata format. Takes track data in on stdin\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: gdarchive
    type: Directory
    doc: "genomedata archive (directory mode). It is copied to the working directory and modified there."
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: trackname
    type: string
    doc: track name
    inputBinding:
      position: 2
  - id: track_data
    type: File
    doc: Track data (for example bedGraph), read from standard input
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print status and diagnostic messages
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
stdin: $(inputs.track_data.path)
stdout: genomedata_genomedata-load-data.out
