cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_footprints.sh
label: footprint_find_footprints.sh
doc: "Finds footprints from ATAC-seq or DNase-seq data.\n\nTool homepage: https://ohlerlab.mdc-berlin.de/software/Reproducible_footprinting_139/"
inputs:
  - id: bam_file
    type: File
    doc: The bam file from the ATAC-seq or DNase-seq experiment.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: A tab delimited file with 2 columns, where the first column is the 
      chromosome name and the second column is the chromosome length for the 
      appropriate organism and genome build.
    inputBinding:
      position: 2
  - id: motif_coords
    type: File
    doc: A 6-column file with the coordinates of motif matches (eg resulting 
      from scanning the genome with a PWM) for the transcription factor of 
      interest. The 6 columns should contain chromosome, start coordinate, end 
      coordinate, name, score and strand information in this order. There should
      not be any additional columns.The coordinates should be closed (1-based).
    inputBinding:
      position: 3
  - id: genome_fasta
    type: File
    doc: A multi-fasta format file that contains the whole genome sequence for 
      the appropriate organism and genome build. This file should be indexed (eg
      by using samtools faidx) and placed in the same directory.
    inputBinding:
      position: 4
  - id: factor_name
    type: string
    doc: The name of the transcription factor of interest supplied by the user. 
      This is used in the naming of the output files.
    inputBinding:
      position: 5
  - id: bias_file
    type: File
    doc: 'A file listing the cleavage/transposition bias of the different protocols,
      for all 6-mers. Provided options: ATAC, DNase double hit or DNase single hit
      protocols.'
    inputBinding:
      position: 6
  - id: peak_file
    type: File
    doc: A file with the coordinates of the ChIP-seq peaks for the transcription
      factor of interest. The format is flexible as long as the first 3 columns 
      (chromosome, start coordinate, end coordinate) are present.
    inputBinding:
      position: 7
  - id: no_of_components
    type: int
    doc: Total number of footprint and background components that should be 
      learned from the data. Options are 2 (1 fp and 1 bg) and 3 (2 fp and 1 bg)
      components.
    inputBinding:
      position: 8
  - id: background
    type: string
    doc: The mode of initialization for the background component. Options are 
      "Flat" or "Seq". Choosing "Flat" initializes this component as a uniform 
      distribution. Choosing "Seq" initializes it as the signal profile that 
      would be expected solely due to the protocol bias (given by the bias_file 
      parameter).
    inputBinding:
      position: 9
  - id: fixed_bg
    type: boolean
    doc: Whether the background component should be kept fixed. Options are 
      TRUE/T or FALSE/F. Setting "TRUE" keeps this component fixed, whereas 
      setting "FALSE" lets it be reestimated during training. In general, if the
      background is estimated from bias (option "Seq"), it is recommended to 
      keep it fixed.
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/footprint:1.0.1--pl5321r41hdfd78af_0
stdout: footprint_find_footprints.sh.out
