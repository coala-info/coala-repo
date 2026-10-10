cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sam_reads_collapse.pl
label: mirdeep2_sam_reads_collapse.pl
doc: "Parse a SAM file and collapse identical reads (minus-strand reads are reverse complemented); the collapsed reads can be used as miRDeep2 input\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: sam_file
    type: File
    doc: SAM file
    inputBinding:
      position: 1
  - id: reads_output_file
    type: string
    doc: Name of the collapsed reads output file (fasta)
    inputBinding:
      position: 2
outputs:
  - id: collapsed_reads
    type: File
    doc: Collapsed reads in fasta format
    outputBinding:
      glob: $(inputs.reads_output_file)
  - id: reads_n_to_1
    type: File
    doc: Table of the ids of reads that were merged into the first read id
    outputBinding:
      glob: reads_N_to_1.txt
  - id: read_1_to_1
    type: File
    doc: Table of first read ids and the new collapsed ids
    outputBinding:
      glob: read_1_to_1.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
