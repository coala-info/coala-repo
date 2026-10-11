cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs_disambiguate
label: ngs-disambiguate_disambiguate
doc: "Disambiguate reads from two species (e.g., human and mouse) in a mixed-species
  sample. It takes two name-sorted BAM files (one for each species) and assigns reads
  to the species with the higher alignment quality.\n\nTool homepage: https://github.com/AstraZeneca-NGS/disambiguate"
inputs:
  - id: species_a_bam
    type: File
    doc: Species A BAM file
    inputBinding:
      position: 1
  - id: species_b_bam
    type: File
    doc: Species B BAM file
    inputBinding:
      position: 2
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner option {tophat(default),hisat2,bwa,star}
    inputBinding:
      position: 103
      prefix: --aligner
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: (Deprecated option for backwards compatibility)
    inputBinding:
      position: 103
      prefix: --no-sort
  - id: prefix
    type: string
    doc: Sample ID or name used as prefix. Do not include .bam
    inputBinding:
      position: 103
      prefix: --prefix
  - id: output_dir_path
    type: string
    doc: Output directory
    inputBinding:
      position: 104
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the disambiguated and ambiguous BAM files and the
      summary text file
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-disambiguate:2018.05.03--h2bd4fab_12
