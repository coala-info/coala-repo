cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-seattleseqkit
  - mergegenes
label: biopet-seattleseqkit_mergegenes
doc: "Merges gene count files (from filter --geneColapseOutput) of several samples
  into one table.\n\nTool homepage: https://github.com/biopet/seattleseqkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: --inputFile
        valueFrom: $(self.nameroot)=$(self.path)
    doc: Gene counts per sample. Each file is passed as <sample>=<file>; the 
      sample name is the file name without its last extension.
    inputBinding:
      position: 101
  - id: output_file_name
    type: string
    doc: Output merges genes counts
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_file
    type: File
    doc: Merged gene counts table
    outputBinding:
      glob: $(inputs.output_file_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
