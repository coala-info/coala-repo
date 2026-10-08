cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Call
label: squire_call
doc: 'Call differentially expressed transposable elements between two groups of samples with DESeq2.


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: group1
  type: string
  doc: List of basenames for group1 (Treatment) samples, can also provide string pattern common to all group1 basenames
  inputBinding:
    position: 1
    prefix: --group1
- id: group2
  type: string
  doc: List of basenames for group2 (Control) samples, can also provide string pattern common to all group2 basenames
  inputBinding:
    position: 1
    prefix: --group2
- id: condition1
  type: string
  doc: Name of condition for group1
  inputBinding:
    position: 1
    prefix: --condition1
- id: condition2
  type: string
  doc: Name of condition for group2
  inputBinding:
    position: 1
    prefix: --condition2
- id: count_folder
  type:
  - 'null'
  - Directory
  doc: Folder location of outputs from SQuIRE Count (optional, default = 'squire_count')
  inputBinding:
    position: 1
    prefix: --count_folder
- id: call_folder
  type: string
  doc: Destination folder for output files (optional; default='squire_call')
  inputBinding:
    position: 1
    prefix: --call_folder
  default: squire_call
- id: subfamily
  type:
  - 'null'
  - boolean
  doc: Compare TE counts by subfamily. Otherwise, compares TEs at locus level (optional; default=False)
  inputBinding:
    position: 1
    prefix: --subfamily
- id: pthreads
  type:
  - 'null'
  - int
  doc: Launch <int> parallel threads(optional; default='1')
  inputBinding:
    position: 1
    prefix: --pthreads
- id: projectname
  type:
  - 'null'
  - string
  doc: Basename for project, default='SQuIRE'
  inputBinding:
    position: 1
    prefix: --projectname
- id: output_format
  type:
  - 'null'
  - string
  doc: Output figures as html or pdf
  inputBinding:
    position: 1
    prefix: --output_format
- id: table_only
  type:
  - 'null'
  - boolean
  doc: Output count table only, don't want to perform differential expression with DESeq2
  inputBinding:
    position: 1
    prefix: --table_only
- id: verbosity
  type:
  - 'null'
  - boolean
  doc: Want messages and runtime printed to stderr (optional; default=False)
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: call_folder_result
  type: Directory
  doc: Destination folder for output files (optional; default='squire_call')
  outputBinding:
    glob: $(inputs.call_folder)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
