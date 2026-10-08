cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - compute_score.R
label: chromeister_compute_score.R
doc: "Compute the CHROMEISTER similarity score of a comparison matrix and write the
  filtered matrix (<matrix>.raw.txt), its plot (<matrix>.filt.png) and the pixel
  coordinates of conserved signals (hits-XY-<matrix>.hits); the score goes to stdout.\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs:
  - id: matrix
    type: File
    doc: comparison matrix written by CHROMEISTER, with its .csv label file 
      beside it
    secondaryFiles:
      - .csv
    inputBinding:
      position: 1
  - id: matsize
    type: int
    doc: size of the matrix (the -dimension used in CHROMEISTER, default 1000)
    inputBinding:
      position: 2
outputs:
  - id: score
    type: stdout
    doc: similarity score
  - id: raw_matrix
    type: File
    doc: filtered comparison matrix (input for detect_events.py)
    outputBinding:
      glob: $(inputs.matrix.basename).raw.txt
  - id: filtered_plot
    type: File
    doc: plot of the filtered comparison matrix
    outputBinding:
      glob: $(inputs.matrix.basename).filt.png
  - id: hits
    type: File
    doc: pixel coordinates of highly conserved signals
    outputBinding:
      glob: hits-XY-$(inputs.matrix.basename).hits
stdout: $(inputs.matrix.nameroot).scr.txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.matrix)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
