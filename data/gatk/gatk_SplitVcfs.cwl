cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SplitVcfs
label: gatk_SplitVcfs
doc: |-
  Splits SNPs and INDELs into separate files. This tool reads in a VCF or BCF file and writes out the SNPs and INDELs it contains to separate files. The headers of the two output files will be identical and index files will be created for both outputs. If records other than SNPs or INDELs are present, set the STRICT option to "false", otherwise the tool will raise an exception and quit.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: indel_output
  type: string
  doc: The VCF or BCF file to which indel records should be written. The file format
    is determined by file extension.
  inputBinding:
    position: 1
    prefix: --INDEL_OUTPUT
- id: input
  type: File
  doc: The VCF or BCF input file
  inputBinding:
    position: 1
    prefix: --INPUT
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: snp_output
  type: string
  doc: The VCF or BCF file to which SNP records should be written. The file format
    is determined by file extension.
  inputBinding:
    position: 1
    prefix: --SNP_OUTPUT
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: The index sequence dictionary to use instead of the sequence dictionaries in
    the input files
  inputBinding:
    position: 1
    prefix: --SEQUENCE_DICTIONARY
- id: strict
  type:
  - 'null'
  - boolean
  doc: 'If true an exception will be thrown if an event type other than SNP or indel
    is encountered Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --STRICT
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: indel_output_file
  type: File
  doc: The VCF or BCF file to which indel records should be written. The file format
    is determined by file extension.
  outputBinding:
    glob: $(inputs.indel_output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: snp_output_file
  type: File
  doc: The VCF or BCF file to which SNP records should be written. The file format
    is determined by file extension.
  outputBinding:
    glob: $(inputs.snp_output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
