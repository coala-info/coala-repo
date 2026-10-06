cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - map2bed.pl
label: art_map2bed
doc: "Convert ART_SOLiD MAP alignment files to a UCSC BED file.\n\nTool homepage:\
  \ https://www.niehs.nih.gov/research/resources/software/biostatistics/art"
inputs:
  - id: out_bed_file
    type: string
    doc: output BED file
    inputBinding:
      position: 1
  - id: in_map_files
    type: File[]
    doc: input ART_SOLiD MAP files
    inputBinding:
      position: 2
outputs:
  - id: bed
    type: File
    doc: BED file of the simulated read positions.
    outputBinding:
      glob: $(inputs.out_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
