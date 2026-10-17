cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_cut_counter.py
label: pydnase_dnase_cut_counter.py
doc: "Annotates a BED file with with the number of DNase cuts in it.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file"
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "The BAM file containing the DNase-seq data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "filename to write the output to"
    inputBinding:
      position: 3
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: annotated_bed
    type: File
    doc: "BED file annotated with cut counts."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
