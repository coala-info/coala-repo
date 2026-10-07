cwlVersion: v1.2
class: CommandLineTool
baseCommand: detect_events.py
label: chromeister_detect_events.py
doc: "Detect genomic events (synteny, inversions, translocations) from Chromeister
  comparison results.\n\nTool homepage: https://github.com/estebanpw/chromeister"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.raw_matrix)
        writable: true
inputs:
  - id: raw_matrix
    type: File
    doc: Raw score matrix (*.mat.raw.txt) written by compute_score.R or 
      compute_score-nogrid.R from a CHROMEISTER comparison matrix
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: png
    type: ['null', boolean]
    doc: Also write an image of the detected events (*.events.png)
    inputBinding:
      position: 2
      valueFrom: png
outputs:
  - id: events
    type: File
    doc: Detected events table (*.events.txt)
    outputBinding:
      glob: $(inputs.raw_matrix.basename.replace(".raw.txt", ".events.txt"))
  - id: events_png
    type: ['null', File]
    doc: Image of the detected events (*.events.png)
    outputBinding:
      glob: $(inputs.raw_matrix.basename.replace(".raw.txt", ".events.png"))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
