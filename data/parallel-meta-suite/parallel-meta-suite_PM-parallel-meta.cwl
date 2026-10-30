cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-parallel-meta
label: parallel-meta-suite_PM-parallel-meta
doc: "Microbiome sample profiling\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: ref_database
    type:
      - 'null'
      - string
    doc: "Reference database (the help gives 'Empty database' as the default text)"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: shotgun_sequence
    type:
      - 'null'
      - File
    doc: "Input single sequence file (Shotgun) [Conflicts with -r and -R]"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: rrna_sequence
    type:
      - 'null'
      - File
    doc: "Input single sequence file (rRNA targeted) [Conflicts with -m]"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: paired_sequence
    type:
      - 'null'
      - File
    doc: "Input paired sequence file [Optional for -r, Conflicts with -m]"
    inputBinding:
      position: 1
      prefix: "-R"
  - id: asv_denoising
    type:
      - 'null'
      - string
    doc: "ASV denoising, T(rue) or F(alse), default is T"
    inputBinding:
      position: 1
      prefix: "-v"
  - id: chimera_removal
    type:
      - 'null'
      - string
    doc: "Chimera removal, T(rue) or F(alse), default is T"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: alignment_threshold
    type:
      - 'null'
      - float
    doc: "Sequence alignment threshold (float value 0-1), default is 0.99 for ASV enabled and 0.97 for ASV disabled (-v F)"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output path, default is \"Result\""
    default: Result
    inputBinding:
      position: 1
      prefix: "-o"
  - id: format_check
    type:
      - 'null'
      - string
    doc: "Sequence format check, T(rue) or F(alse), default is F"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: rrna_length_threshold
    type:
      - 'null'
      - int
    doc: "rRNA length threshold of rRNA extraction. 0 is disabled, default is 0 [Optional for -m, Conflicts with -r]"
    inputBinding:
      position: 1
      prefix: "-L"
  - id: functional_analysis
    type:
      - 'null'
      - string
    doc: "Functional analysis, T(rue) or F(alse), default is T"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default is auto"
    inputBinding:
      position: 1
      prefix: "-t"
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Profiling results of the sample"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-parallel-meta.out
