cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, align, summary]
label: segul_align_summary
doc: "Compute Alignment Statistics\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: dir
    type: ['null', Directory]
    doc: "Input a directory"
    inputBinding:
      position: 1
      prefix: "--dir"
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input path(s) (wildcards are expanded by the tool, so give files)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: input_format
    type: ['null', string]
    doc: "Input format: auto, fasta, nexus, phylip (default auto)"
    inputBinding:
      position: 1
      prefix: "--input-format"
  - id: datatype
    type: ['null', string]
    doc: "Sequence datatype: dna, aa, ignore (default dna)"
    inputBinding:
      position: 1
      prefix: "--datatype"
  - id: output
    type: string
    default: "Align-Summary"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: prefix
    type: ['null', string]
    doc: "Prefix for output files"
    inputBinding:
      position: 1
      prefix: "--prefix"
  - id: interval
    type: ['null', int]
    doc: "Interval value for counting data matrix completeness: 1, 2, 5 or 10 (default 5)"
    inputBinding:
      position: 1
      prefix: "--interval"
  - id: per_locus
    type: ['null', boolean]
    doc: "Generate summary statistic for each locus"
    inputBinding:
      position: 1
      prefix: "--per-locus"
outputs:
  - id: output_path
    type: [File, Directory]
    doc: Output file or directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_align_summary.out
