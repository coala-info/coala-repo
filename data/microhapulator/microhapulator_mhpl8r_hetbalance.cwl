cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - hetbalance
label: microhapulator_mhpl8r_hetbalance
doc: "Compute and plot heterozygote balance\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: csv
    type: ['null', string]
    doc: "write read counts to FILE in CSV format"
    inputBinding:
      position: 1
      prefix: --csv
  - id: figure
    type: ['null', string]
    doc: "plot the bar graph or histogram to FILE using Matplotlib; image format is inferred from extension of provided file name"
    inputBinding:
      position: 1
      prefix: --figure
  - id: figsize
    type:
      - 'null'
      - type: array
        items: float
    doc: "dimensions (width and height in inches) of the image file to be generated (two values: W H)"
    inputBinding:
      position: 1
      prefix: --figsize
  - id: dpi
    type: ['null', int]
    doc: "resolution (in dots per inch) of the image file to be generated; DPI=200 by default"
    inputBinding:
      position: 1
      prefix: --dpi
  - id: title
    type: ['null', string]
    doc: "add a title (such as a sample name) to the histogram plot"
    inputBinding:
      position: 1
      prefix: --title
  - id: labels
    type: ['null', boolean]
    doc: "include labels showing marker names and read counts"
    inputBinding:
      position: 1
      prefix: --labels
  - id: absolute
    type: ['null', boolean]
    doc: "plot absolute rather than relative read counts"
    inputBinding:
      position: 1
      prefix: --absolute
  - id: input
    type: File
    doc: "a typing result including haplotype counts in JSON format"
    inputBinding:
      position: 2
outputs:
  - id: report
    type: stdout
    doc: "Extent of heterozygote imbalance (t-statistic)"
  - id: csv_file
    type: ['null', File]
    doc: "Read counts in CSV format (written with --csv)"
    outputBinding:
      glob: $(inputs.csv)
  - id: figure_file
    type: ['null', File]
    doc: "Plot image (written with --figure)"
    outputBinding:
      glob: $(inputs.figure)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
stdout: hetbalance.txt
