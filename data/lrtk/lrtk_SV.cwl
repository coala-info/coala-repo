cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - SV
label: lrtk_SV
doc: "Detect structural variations from a linked-read alignment file with Aquila, LinkedSV or VALOR.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
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
  - id: vcf
    type:
      - 'null'
      - File
    doc: The precalled SNV/INDEL variants required for Aquila.
    inputBinding:
      position: 1
      prefix: -V
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
          - Aquila
          - LinkedSV
          - VALOR
    doc: The SV caller. Users can choose from (Aquila, LinkedSV, VALOR).
    inputBinding:
      position: 1
      prefix: -A
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, this determines the number of threads used for SV caller.
    inputBinding:
      position: 1
      prefix: -T
  - id: uniqness
    type:
      - 'null'
      - Directory
    doc: The uniqness database is required for Aquila.
    inputBinding:
      position: 1
      prefix: -U
  - id: sonic
    type:
      - 'null'
      - File
    doc: The sonic database is required for VALOR.
    inputBinding:
      position: 1
      prefix: -S
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
    type:
      - 'null'
      - File
    doc: The final VCF file (Aquila writes it bgzip-compressed with a tabix index).
    secondaryFiles:
      - pattern: .tbi
        required: false
    outputBinding:
      glob:
        - $(inputs.outfile)
        - $(inputs.outfile).gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
