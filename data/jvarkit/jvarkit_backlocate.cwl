cwlVersion: v1.2
class: CommandLineTool
baseCommand: backlocate
label: jvarkit_backlocate
doc: "Backlocate sequences to genomic coordinates.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Files to process
    inputBinding:
      position: 1
  - id: gtf_file
    type: File
    doc: A GTF (General Transfer Format) file. See 
      https://www.ensembl.org/info/website/upload/gff.html . Please note that 
      CDS are only detected if a start and stop codons are defined.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: help_format
    type:
      - 'null'
      - string
    doc: What kind of help. One of [usage,markdown,xml].
    default: usage
    inputBinding:
      position: 102
      prefix: --helpFormat
  - id: print_seq
    type:
      - 'null'
      - boolean
    doc: print mRNA & protein sequences
    default: false
    inputBinding:
      position: 102
      prefix: --printSeq
  - id: reference
    type: File
    doc: Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file. Optional . Default: stdout'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
