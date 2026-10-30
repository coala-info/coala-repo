cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_apply_paste
doc: "Compute a statistic of a track over each region of a BED file and append it to each BED line (extraction apply_paste).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: apply_paste
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: $(inputs.statistic)
inputs:
  - id: statistic
    type:
      type: enum
      name: apply_paste_statistic
      symbols: [AUC, meanI, varI, minI, maxI, stddevI, CVI, energy]
    doc: Statistic computed on the data track over each region (energy needs the wavelength input).
  - id: wavelength
    type: ['null', float]
    doc: Wavelength, only for the energy statistic.
    inputBinding:
      position: 4
  - id: regions
    type: File
    doc: BED file with the regions; each line is copied to the output with the statistic appended.
    inputBinding:
      position: 5
  - id: data
    type: File
    doc: Data track the statistic is computed on.
    inputBinding:
      position: 6
  - id: output_name
    type: string
    doc: Output text file.
    default: apply_paste.txt
outputs:
  - id: output_file
    type: File
    doc: The BED lines with the statistic appended as last column.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
