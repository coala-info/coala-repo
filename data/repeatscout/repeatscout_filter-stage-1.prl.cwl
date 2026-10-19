cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter-stage-1.prl
label: repeatscout_filter-stage-1.prl
doc: "a first stage post-processing tool for RepeatScout output. Filters out any
  sequence of a repeat library that is more than 50% low-complexity by TRF or dustmasker.
  Reads the library from standard input.\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TRF_COMMAND
        envValue: '$(inputs.trf_command === null ? "trf" : inputs.trf_command)'
      - envName: DUSTMASKER_COMMAND
        envValue: '$(inputs.dustmasker_command === null ? "dustmasker" : inputs.dustmasker_command)'
inputs:
  - id: input_file
    type: File
    doc: Input repeat library (Fasta-formatted sequence file), read from standard input
  - id: dustmasker_command
    type:
      - 'null'
      - string
    doc: Path to the dustmasker executable (environment variable DUSTMASKER_COMMAND). If not set, dustmasker must be in 
      PATH.
  - id: trf_command
    type:
      - 'null'
      - string
    doc: Path to the TRF executable (environment variable TRF_COMMAND). If not set, TRF must be in PATH.
stdin: $(inputs.input_file.path)
outputs:
  - id: filtered_library
    type: stdout
    doc: Filtered repeat library (Fasta-formatted sequence file)
stdout: $(inputs.input_file.nameroot).filtered.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
