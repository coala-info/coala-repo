cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_ttnfitness
label: transit_ttnfitness
doc: "Calculates fitness based on transit data.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig files
    inputBinding:
      position: 1
  - id: annotation_prot_table
    type: File
    doc: Annotation .prot_table file
    inputBinding:
      position: 2
  - id: genome_fna
    type: File
    doc: Genome .fna file
    inputBinding:
      position: 3
outputs:
  - id: gumbel_output_file
    type: File
    doc: Gumbel output file
    outputBinding:
      glob: '*.out'
  - id: output1_file
    type: File
    doc: Output file 1
    outputBinding:
      glob: '*.out'
  - id: output2_file
    type: File
    doc: Output file 2
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
