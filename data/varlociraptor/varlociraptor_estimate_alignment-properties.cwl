cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - estimate
  - alignment-properties
label: varlociraptor_estimate_alignment-properties
doc: 'Estimate properties like insert size, maximum softclip length, and the PCR homopolymer
  error model. The JSON result goes to standard output.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: FASTA file with reference genome. Has to be indexed with samtools faidx.
    inputBinding:
      position: 1
  - id: bams
    type:
      type: array
      items: File
    doc: BAM files with aligned reads from a single sample or a set of samples that
      have been sequenced and prepared in exactly the same way.
    secondaryFiles:
      - .bai
    inputBinding:
      position: 100
      prefix: --bams
  - id: num_records
    type:
      - 'null'
      - int
    doc: Number of records to sample from the BAM file
    inputBinding:
      position: 100
      prefix: --num-records
outputs:
  - id: alignment_properties
    type: stdout
    doc: Alignment properties JSON
stdout: alignment-properties.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
