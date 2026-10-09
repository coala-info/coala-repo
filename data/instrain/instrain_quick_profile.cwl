cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - quick_profile
label: instrain_quick_profile
doc: "Quickly calculate coverage and breadth of a mapping using coverM\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: bam
    type: File
    doc: Sorted .bam file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Fasta file the bam is mapped to
    inputBinding:
      position: 2
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: stb
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Scaffold to bin. A file with each line listing a scaffold and a bin name, tab-separated, or a list of .fasta files with one genome per .fasta file. If nothing is provided, all scaffolds are treated as belonging to the same genome'
    inputBinding:
      position: 101
      prefix: --stb
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output prefix (default: QuickProfile)'
    default: QuickProfile
    inputBinding:
      position: 101
      prefix: --output
  - id: breadth_cutoff
    type:
      - 'null'
      - float
    doc: 'Minimum genome breadth to pull scaffolds (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --breadth_cutoff
  - id: stringent_breadth_cutoff
    type:
      - 'null'
      - float
    doc: 'Minimum breadth to let scaffold into coverm raw results (done with greater than; NOT greater than or equal to) (default: 0.0)'
    inputBinding:
      position: 101
      prefix: --stringent_breadth_cutoff
outputs:
  - id: quick_profile_files
    type: File[]
    doc: Quick profile result tables (named by the output prefix)
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
