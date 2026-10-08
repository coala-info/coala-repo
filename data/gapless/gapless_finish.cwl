cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapless.py
  - finish
label: gapless_finish
doc: "Creates previously defined scaffolds. Only providing necessary reads increases speed and substantially reduces memory requirements.\n\nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: assembly
    type: File
    doc: "Split assembly in FASTA format ({assembly}.fa)"
    inputBinding:
      position: 2
  - id: reads
    type: File
    doc: "Reads used for scaffolding ({reads}.fq)"
    inputBinding:
      position: 3
  - id: scaffolds
    type: File
    doc: "Csv file from previous steps describing the scaffolding (mandatory)"
    inputBinding:
      position: 1
      prefix: --scaffolds
  - id: format
    type:
      - 'null'
      - string
    doc: "Format of {reads}.fq (fasta/fastq) (Default: fastq if not determinable from read ending)"
    inputBinding:
      position: 1
      prefix: --format
  - id: hap
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {output} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file for modified assembly ({assembly}_gapless.fa)"
    inputBinding:
      position: 1
      prefix: --output
  - id: polishing
    type:
      - 'null'
      - File
    doc: "Input file for polishing read information"
    inputBinding:
      position: 1
      prefix: --polishing
  - id: hap1
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out1} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap1
  - id: hap2
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out2} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap2
  - id: hap3
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out3} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap3
  - id: hap4
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out4} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap4
  - id: hap5
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out5} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap5
  - id: hap6
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out6} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap6
  - id: hap7
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out7} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap7
  - id: hap8
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out8} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap8
  - id: hap9
    type:
      - 'null'
      - int
    doc: "Haplotype starting from 0 written to {out9} (default: mixed)"
    inputBinding:
      position: 1
      prefix: --hap9
  - id: out1
    type:
      - 'null'
      - string
    doc: "Additional output file 1 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out1
  - id: out2
    type:
      - 'null'
      - string
    doc: "Additional output file 2 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out2
  - id: out3
    type:
      - 'null'
      - string
    doc: "Additional output file 3 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out3
  - id: out4
    type:
      - 'null'
      - string
    doc: "Additional output file 4 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out4
  - id: out5
    type:
      - 'null'
      - string
    doc: "Additional output file 5 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out5
  - id: out6
    type:
      - 'null'
      - string
    doc: "Additional output file 6 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out6
  - id: out7
    type:
      - 'null'
      - string
    doc: "Additional output file 7 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out7
  - id: out8
    type:
      - 'null'
      - string
    doc: "Additional output file 8 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out8
  - id: out9
    type:
      - 'null'
      - string
    doc: "Additional output file 9 for modified assembly (deactivated)"
    inputBinding:
      position: 1
      prefix: --out9
outputs:
  - id: finished_assembly
    type: File
    doc: Modified assembly
    outputBinding:
      glob: '${ return inputs.output ? inputs.output : inputs.assembly.nameroot + "_gapless.fa"; }'
  - id: finished_assembly1
    type:
      - 'null'
      - File
    doc: Additional modified assembly 1 (only with out1)
    outputBinding:
      glob: $(inputs.out1)
  - id: finished_assembly2
    type:
      - 'null'
      - File
    doc: Additional modified assembly 2 (only with out2)
    outputBinding:
      glob: $(inputs.out2)
  - id: finished_assembly3
    type:
      - 'null'
      - File
    doc: Additional modified assembly 3 (only with out3)
    outputBinding:
      glob: $(inputs.out3)
  - id: finished_assembly4
    type:
      - 'null'
      - File
    doc: Additional modified assembly 4 (only with out4)
    outputBinding:
      glob: $(inputs.out4)
  - id: finished_assembly5
    type:
      - 'null'
      - File
    doc: Additional modified assembly 5 (only with out5)
    outputBinding:
      glob: $(inputs.out5)
  - id: finished_assembly6
    type:
      - 'null'
      - File
    doc: Additional modified assembly 6 (only with out6)
    outputBinding:
      glob: $(inputs.out6)
  - id: finished_assembly7
    type:
      - 'null'
      - File
    doc: Additional modified assembly 7 (only with out7)
    outputBinding:
      glob: $(inputs.out7)
  - id: finished_assembly8
    type:
      - 'null'
      - File
    doc: Additional modified assembly 8 (only with out8)
    outputBinding:
      glob: $(inputs.out8)
  - id: finished_assembly9
    type:
      - 'null'
      - File
    doc: Additional modified assembly 9 (only with out9)
    outputBinding:
      glob: $(inputs.out9)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
