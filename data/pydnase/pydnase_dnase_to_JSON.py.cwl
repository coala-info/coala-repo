cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_to_JSON.py
label: pydnase_dnase_to_JSON.py
doc: "Writes a JSON file of DNase I cuts for regions from a BED file.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file of the regions"
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "BAM file containing the read data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "filename to write the JSON output to"
    inputBinding:
      position: 3
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Resize all regions to a specific length."
    inputBinding:
      position: 10
      prefix: --window_size
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: "Ignores strand information in BED file."
    inputBinding:
      position: 11
      prefix: -i
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: cuts_json
    type: File
    doc: "JSON file of DNase I cuts."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
