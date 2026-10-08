cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - locbalance
label: microhapulator_mhpl8r_locbalance
doc: "Plot interlocus balance in the terminal and/or a high-resolution graphic. Also normalize read counts and perform a chi-square goodness-of-fit test assuming uniform read coverage across markers.\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: csv
    type: ['null', string]
    doc: "write read counts to FILE in CSV format"
    inputBinding:
      position: 1
      prefix: --csv
  - id: no_discarded
    type: ['null', boolean]
    doc: "do not included mapping but discarded reads in read counts; by default, reads that are mapped to the marker but discarded because they do not span all variants at the marker are included"
    inputBinding:
      position: 1
      prefix: --no-discarded
  - id: quiet
    type: ['null', boolean]
    doc: "do not print interlocus balance histogram to standard output in ASCII"
    inputBinding:
      position: 1
      prefix: --quiet
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
  - id: color
    type: ['null', string]
    doc: "override histogram plot color; green by default"
    inputBinding:
      position: 1
      prefix: --color
  - id: input
    type: File
    doc: "a typing result including haplotype counts in JSON format"
    inputBinding:
      position: 2
outputs:
  - id: report
    type: stdout
    doc: "ASCII interlocus balance histogram and chi-square statistic"
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
stdout: locbalance.txt
