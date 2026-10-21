cwlVersion: v1.2
class: CommandLineTool
baseCommand: [MatchesByFeature]
label: satsuma2_MatchesByFeature
doc: "Reports how many bases of each match file (three columns: chromosome, start, end) fall into each feature type of a GFF3 file. The GFF3 file must contain chromosome features with short names. Usage: MatchesByFeature gff3_file <gff_features> <match_files>.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: gff3_file
    type: File
    doc: "GFF3 file with chromosome features"
    inputBinding:
      position: 1
  - id: features
    type: string[]
    doc: "GFF3 feature types to count (at most 7); unused slots are filled with '-'"
    inputBinding:
      position: 2
      valueFrom: "${ var r = self.slice(); while (r.length < 7) { r.push('-'); } return r; }"
  - id: match_files
    type: File[]
    doc: "match files with three columns: chromosome, start, end"
    inputBinding:
      position: 3
outputs:
  - id: feature_table
    type: stdout
    doc: "Comma separated table of bases and percent bases per feature, written to standard output"
stdout: matches_by_feature.csv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
