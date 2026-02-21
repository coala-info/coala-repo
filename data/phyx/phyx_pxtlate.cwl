cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxtlate
label: phyx_pxtlate
doc: "Translate DNA alignment to amino acids. This will take fasta, fastq, phylip,
  and nexus formats from a file or STDIN. NOTE: assumes sequences are in frame.\n\n
  Tool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: seq_file
    type:
      - 'null'
      - File
    doc: input nucleotide sequence file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
  - id: translation_table
    type:
      - 'null'
      - string
    doc: "which translation table to use. currently available: 'std' (standard, default),
      'vmt' (vertebrate mtDNA), 'ivmt' (invertebrate mtDNA), 'ymt' (yeast mtDNA)"
    default: std
    inputBinding:
      position: 101
      prefix: --table
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output aa sequence file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
