cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - ttnfitness
label: transit_ttnfitness
doc: "Estimates the fitness of each gene corrected for the effect of the sequence around the TA site (TTN, Tn5 libraries), using a Gumbel result file.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type: File[]
    doc: "Comma-separated .wig files"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: annotation_prot_table
    type: File
    doc: "Annotation .prot_table file"
    inputBinding:
      position: 2
  - id: genome_fna
    type: File
    doc: "Genome .fna file"
    inputBinding:
      position: 3
  - id: gumbel_output_file
    type: File
    doc: "Output file of the gumbel method"
    inputBinding:
      position: 4
  - id: output1_filename
    type: string
    doc: "Name of the first output file"
    inputBinding:
      position: 5
  - id: output2_filename
    type: string
    doc: "Name of the second output file"
    inputBinding:
      position: 6
outputs:
  - id: output1_file
    type: File
    doc: "First output file"
    outputBinding:
      glob: $(inputs.output1_filename)
  - id: output2_file
    type: File
    doc: "Second output file"
    outputBinding:
      glob: $(inputs.output2_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
