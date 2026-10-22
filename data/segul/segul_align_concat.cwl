cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, align, concat]
label: segul_align_concat
doc: "Concatenate alignments\n\nTool homepage: https://github.com/hhandika/segul"
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
  - id: output_format
    type: ['null', string]
    doc: "Output format: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int (default nexus)"
    inputBinding:
      position: 1
      prefix: "--output-format"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: partition_format
    type: ['null', string]
    doc: "Partition output format: charset, nexus, raxml (default nexus)"
    inputBinding:
      position: 1
      prefix: "--partition-format"
  - id: codon
    type: ['null', boolean]
    doc: "Set as a codon model partition format"
    inputBinding:
      position: 1
      prefix: "--codon"
  - id: prefix
    type: ['null', string]
    doc: "Prefix for output files"
    inputBinding:
      position: 1
      prefix: "--prefix"
  - id: output
    type: string
    default: "Align-Concat"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: sort
    type: ['null', boolean]
    doc: "Sort sequences by IDs alphabetically"
    inputBinding:
      position: 1
      prefix: "--sort"
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
stdout: segul_align_concat.out
