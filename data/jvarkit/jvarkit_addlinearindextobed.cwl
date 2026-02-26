cwlVersion: v1.2
class: CommandLineTool
baseCommand: addlinearindextobed
label: jvarkit_addlinearindextobed
doc: "Add linear index to BED file\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BED files
    inputBinding:
      position: 1
  - id: dict
    type: File
    doc: "A SAM Sequence dictionary source: it can be a *.dict file, a fasta file
      indexed with 'picard CreateSequenceDictionary' or 'samtools dict', or any hts
      file containing a dictionary (VCF, BAM, CRAM, intervals...)"
    inputBinding:
      position: 102
      prefix: --dict
  - id: help_format
    type:
      - 'null'
      - string
    doc: What kind of help. One of [usage,markdown,xml].
    default: usage
    inputBinding:
      position: 102
      prefix: --helpFormat
  - id: reference
    type: File
    doc: "A SAM Sequence dictionary source: it can be a *.dict file, a fasta file
      indexed with 'picard CreateSequenceDictionary' or 'samtools dict', or any hts
      file containing a dictionary (VCF, BAM, CRAM, intervals...)"
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file. Optional .
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
