cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_print
doc: "Save a statistic of a track into a text file (the print statement).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: print
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: $(inputs.statistic)
inputs:
  - id: statistic
    type:
      type: enum
      name: print_statistic
      symbols: [AUC, meanI, varI, minI, maxI, stddevI, CVI, energy]
    doc: Statistic computed on the track (energy needs the wavelength input).
  - id: wavelength
    type: ['null', float]
    doc: Wavelength, only for the energy statistic.
    inputBinding:
      position: 4
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 5
  - id: output_name
    type: string
    doc: Output text file (use '-' for standard output).
    default: out.txt
outputs:
  - id: output_file
    type: File
    doc: Text file with the statistic.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
