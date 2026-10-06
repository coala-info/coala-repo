cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpfstats
label: admixtools_qpfstats
doc: "Compute f-statistics for AdmixTools\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: do_analysis
    type:
      - 'null'
      - boolean
    doc: toggle doAnalysis ON
    inputBinding:
      position: 102
      prefix: -x
  - id: g_option
    type:
      - 'null'
      - string
    doc: g option
    inputBinding:
      position: 102
      prefix: -g
  - id: lambda_scale
    type:
      - 'null'
      - float
    doc: use <val> as lambda scale
    inputBinding:
      position: 102
      prefix: -l
  - id: parameter_file
    type: File
    doc: use parameters from <file>
    inputBinding:
      position: 102
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: use <val> as seed
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: toggle verbose mode ON
    inputBinding:
      position: 102
      prefix: -V
  - id: output_option_path
    type:
      - 'null'
      - string
    doc: Name given to fstatsoutname in the parameter file (qpfstats ignores 
      -o and writes the f-statistics file named there).
  - id: data_files
    type:
      type: array
      items: File
    doc: Genotype, SNP, individual and population list files that the 
      parameter file names. They are staged into the working directory, so 
      the parameter file must refer to them by file name only.
outputs:
  - id: output_option
    type:
      - 'null'
      - File
    doc: output option
    outputBinding:
      glob: $(inputs.output_option_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpfstats.out
