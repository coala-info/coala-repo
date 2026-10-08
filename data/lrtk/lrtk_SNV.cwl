cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - SNV
label: lrtk_SNV
doc: "Call SNVs and small indels from an alignment file with FreeBayes, inStrain, Samtools or GATK.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
inputs:
  - id: bam
    type: File
    doc: The alignment file (.bam).
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: -B
  - id: reference
    type: File
    doc: The indexed human reference genome file.
    secondaryFiles:
      - pattern: .fai
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 1
      prefix: -R
  - id: application
    type:
      - 'null'
      - type: enum
        symbols:
          - FreeBayes
          - inStrain
          - Samtools
          - GATK
    doc: The SNV/INDEL caller
    inputBinding:
      position: 1
      prefix: -A
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, this determines the number of threads used for SNV/INDEL caller.
    inputBinding:
      position: 1
      prefix: -T
  - id: outfile
    type: string
    doc: The final VCF file to write.
    inputBinding:
      position: 1
      prefix: -O
  - id: genome
    type:
      - 'null'
      - type: enum
        symbols:
          - human
          - metagenome
    doc: genome pattern to process
    inputBinding:
      position: 1
      prefix: -G
outputs:
  - id: variants
    type: File
    doc: The final VCF file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
