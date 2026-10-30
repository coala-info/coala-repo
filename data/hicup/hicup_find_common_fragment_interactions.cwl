cwlVersion: v1.2
class: CommandLineTool
baseCommand: [find_common_fragment_interactions.pl]
label: hicup_find_common_fragment_interactions
doc: "Compare pairs of fragment interaction matrix files and report the interactions common and not common to both files of each pair.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: matrix_files
    type: File[]
    doc: "Interaction matrix files (from make_hic_array.pl), an even number, compared in pairs: file1 file2 file3 file4"
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: common
    type: File[]
    doc: "Interactions present in both files of a pair"
    outputBinding:
      glob: "*.AND.*.gz"
  - id: not_common
    type: File[]
    doc: "Interactions present in only one file of a pair"
    outputBinding:
      glob: "*.NOT.*.gz"
  - id: summary
    type: File
    doc: "Summary counts per pair"
    outputBinding:
      glob: "common_fragment_interactions_summary.txt"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.matrix_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
