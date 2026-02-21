cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - combine
label: flair_combine
doc: "Combine transcriptomes from multiple samples based on a manifest file.\n\nTool
  homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: convert_gtf
    type:
      - 'null'
      - boolean
    doc: '[optional] whether to convert the combined transcriptome bed file to gtf'
    inputBinding:
      position: 101
      prefix: --convert_gtf
  - id: endwindow
    type:
      - 'null'
      - int
    doc: window for comparing ends of isoforms with the same intron chain. Default:200bp
    default: 200
    inputBinding:
      position: 101
      prefix: --endwindow
  - id: filter
    type:
      - 'null'
      - string
    doc: 'type of filtering. Options: usageandlongest(default), usageonly, none, or
      a number for the total count of reads required to call an isoform'
    default: usageandlongest
    inputBinding:
      position: 101
      prefix: --filter
  - id: include_se
    type:
      - 'null'
      - boolean
    doc: 'whether to include single exon isoforms. Default: dont include'
    inputBinding:
      position: 101
      prefix: --include_se
  - id: manifest
    type: File
    doc: path to manifest files that points to transcriptomes to combine. Each line
      of file should be tab separated with sample name, sample type (isoform or fusionisoform),
      path/to/isoforms.bed, path/to/isoforms.fa, path/to/combined.isoform.read.map.txt.
      fa and read.map.txt files are not required, although if .fa files are not provided
      for each sample a .fa output will not be generated
    inputBinding:
      position: 101
      prefix: --manifest
  - id: minpercentusage
    type:
      - 'null'
      - int
    doc: minimum percent usage required in one sample to keep isoform in combined
      transcriptome. Default:10
    default: 10
    inputBinding:
      position: 101
      prefix: --minpercentusage
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: "path to collapsed_output.bed file. default: 'collapsed_flairomes'"
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
