cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_energy
doc: "Energy density of a track at a given wavelength (statistic energy).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: wavelength
    type: float
    doc: Wavelength.
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 3
arguments:
  - position: 1
    valueFrom: energy
stdout: energy.txt
outputs:
  - id: result
    type: stdout
    doc: The statistic, printed as a single number.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
