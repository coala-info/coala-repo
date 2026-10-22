cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - denoise
label: thapbi-pict_denoise
doc: "Apply UNOISE based read-correction to denoise FASTA file(s).\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "One or more input FASTA files named <prefix>_<count>."
    inputBinding:
      position: 101
      prefix: -i
  - id: output
    type:
      - 'null'
      - string
    doc: "Single output FASTA filename, '-' for stdout (default)."
    inputBinding:
      position: 101
      prefix: -o
  - id: denoise
    type:
      - 'null'
      - string
    doc: "Choice of read-correction algorithm: unoise-l (default), usearch or vsearch."
    inputBinding:
      position: 101
      prefix: --denoise
  - id: unoise_alpha
    type:
      - 'null'
      - float
    doc: "UNOISE read-correction alpha parameter, used in skew threshold function beta. Default 2.0 for UNOISE-L."
    inputBinding:
      position: 101
      prefix: --unoise-alpha
  - id: unoise_gamma
    type:
      - 'null'
      - int
    doc: "UNOISE read-correction gamma parameter. Variants below this total abundance are discarded before denoising. Default 4 for UNOISE-L."
    inputBinding:
      position: 101
      prefix: --unoise-gamma
  - id: total
    type:
      - 'null'
      - int
    doc: "Minimum total abundance for each output sequence. Default 0 (not used)."
    inputBinding:
      position: 101
      prefix: -t
  - id: minlen
    type:
      - 'null'
      - int
    doc: "Minimum length sequence to accept (default 100)."
    inputBinding:
      position: 101
      prefix: --minlen
  - id: maxlen
    type:
      - 'null'
      - int
    doc: "Maximum length sequence to accept (default 1000)."
    inputBinding:
      position: 101
      prefix: --maxlen
  - id: temp
    type:
      - 'null'
      - string
    doc: "Debug option. Specify an (ideally empty) directory to use for temporary files, which will not be deleted."
    inputBinding:
      position: 101
      prefix: --temp
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of parallel threads to use in called tools. Use zero for all available. Default 1."
    inputBinding:
      position: 101
      prefix: --cpu
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Denoised FASTA file"
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
    doc: "Standard output when no output file is given"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_denoise.out
