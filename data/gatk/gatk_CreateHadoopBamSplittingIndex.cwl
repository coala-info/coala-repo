cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CreateHadoopBamSplittingIndex
label: gatk_CreateHadoopBamSplittingIndex
doc: |-
  Create a Hadoop BAM splitting index and optionally a BAM index from a BAM file

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  doc: BAM file to create a HadoopBam splitting index for
  inputBinding:
    prefix: --input
- id: create_bai
  type:
  - 'null'
  - boolean
  doc: 'Set this to create a bai index at the same time as creating a splitting index
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --create-bai
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: output
  type:
  - 'null'
  - string
  doc: The splitting index (SBI) file. If this is unspecified an index will be created
    with the same name as the input file but with the additional extension .sbi
  inputBinding:
    prefix: --output
- id: splitting_index_granularity
  type:
  - 'null'
  - long
  doc: 'Splitting index granularity, an entry is created in the index every this many
    reads. Default value: 4096.'
  inputBinding:
    prefix: --splitting-index-granularity
outputs:
- id: splitting_index
  type: File
  doc: The splitting index (SBI) file, written next to the staged input unless output
    is given
  outputBinding:
    glob: ${ if (inputs.output) { return inputs.output; } return inputs.input.basename
      + '.sbi'; }
- id: bam_index
  type:
  - 'null'
  - File
  doc: BAM index (BAI) written when create_bai is set
  outputBinding:
    glob: $(inputs.input.basename).bai
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.input)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
