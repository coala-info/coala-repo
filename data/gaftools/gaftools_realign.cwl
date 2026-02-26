cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gaftools
  - realign
label: gaftools_realign
doc: "Realign a GAF file using wavefront alignment algorithm (WFA).\n\nTool homepage:
  https://github.com/marschall-lab/gaftools"
inputs:
  - id: gaf_file
    type: File
    doc: GAF file (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: gfa_file
    type: File
    doc: GFA file (can be bgzip-compressed)
    inputBinding:
      position: 2
  - id: fasta_file
    type: File
    doc: FASTA file of the read
    inputBinding:
      position: 3
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use for alignments.
    inputBinding:
      position: 104
      prefix: --cores
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output GAF file (bgzipped if the file ends with .gz). If omitted, use 
      standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
