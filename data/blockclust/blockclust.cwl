cwlVersion: v1.2
class: CommandLineTool
baseCommand: blockclust
label: blockclust
doc: "Efficient clustering and classification of non-coding RNAs from short read RNA-seq
  profiles\n\nTool homepage: https://github.com/pavanvidem/blockclust"
inputs:
  - id: accept
    type: File
    doc: accept annotations (BED of known ncRNAs, e.g. share/blockclust_data/hg19/hg19.accept.bed)
    inputBinding:
      position: 101
      prefix: --accept
  - id: config
    type: File
    doc: config file (e.g. share/blockclust_data/blockclust.config)
    inputBinding:
      position: 101
      prefix: --config
  - id: in
    type: File
    doc: blockbuster output
    inputBinding:
      position: 101
      prefix: --in
  - id: reject
    type: File
    doc: reject annotations (BED of other known transcripts, e.g. share/blockclust_data/hg19/hg19.reject.bed)
    inputBinding:
      position: 101
      prefix: --reject
  - id: out_path
    type: string
    doc: output dir (created before the run; the tool does not create it)
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: Directory
    doc: output dir
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return {"class": "Directory", "basename": inputs.out_path, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
