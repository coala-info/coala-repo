cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller-parse
label: epimuller_parse
doc: "Parses a GISAID FASTA file with the ISO date after the last '|' in each name into a metadata TSV and a renamed FASTA file.\n\nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs:
  - id: in_fasta
    type: File
    doc: "full metadata file with ISO date after last '|' in name"
    inputBinding:
      position: 101
      prefix: --inFasta
  - id: out_meta
    type: string
    doc: "output for metadata file"
    inputBinding:
      position: 101
      prefix: --outMeta
  - id: out_fasta
    type: string
    doc: "output for fasta file"
    inputBinding:
      position: 101
      prefix: --outFasta
  - id: in_pangolin
    type:
      - 'null'
      - File
    doc: "pangolin output lineage_report.csv file, if argument not supplied adds ? in 'lineage' col"
    inputBinding:
      position: 101
      prefix: --inPangolin
outputs:
  - id: meta
    type: File
    doc: Metadata TSV file
    outputBinding:
      glob: $(inputs.out_meta)
  - id: fasta
    type: File
    doc: Renamed FASTA file
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller_parse.out
