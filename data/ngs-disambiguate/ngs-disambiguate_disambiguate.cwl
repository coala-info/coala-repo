cwlVersion: v1.2
class: CommandLineTool
baseCommand: disambiguate
label: ngs-disambiguate_disambiguate
doc: "Disambiguate reads from two species (e.g., human and mouse) in a mixed-species
  sample. It takes two BAM files (one for each species) and assigns reads to the species
  with the higher alignment quality.\n\nTool homepage: https://github.com/AstraZeneca-NGS/disambiguate"
inputs:
  - id: species_a_bam
    type: File
    doc: BAM file for species A
    inputBinding:
      position: 1
  - id: species_b_bam
    type: File
    doc: BAM file for species B
    inputBinding:
      position: 2
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner used (e.g., bwa, bowtie2, tophat2, star, hisat2)
    inputBinding:
      position: 103
      prefix: --aligner
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort the output BAM files
    inputBinding:
      position: 103
      prefix: --no-sort
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 103
      prefix: --prefix
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort the output BAM files
    inputBinding:
      position: 103
      prefix: --sort
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-disambiguate:2018.05.03--h2bd4fab_12
