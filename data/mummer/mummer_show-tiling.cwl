cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - show-tiling
label: mummer_show-tiling
doc: "Predict the location of each aligning query contig on the reference sequences (a tiling path) from a delta file, optionally writing a pseudo molecule of the contigs.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
    dockerOutputDirectory: /data
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference)
      - $(inputs.query)
inputs:
  - id: print_alignments
    type:
      - 'null'
      - boolean
    doc: "Describe the tiling path by printing the tab-delimited alignment region coordinates to stdout"
    inputBinding:
      position: 1
      prefix: "-a"
  - id: circular
    type:
      - 'null'
      - boolean
    doc: "Assume the reference sequences are circular, and allow tiled contigs to span the origin"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: max_gap
    type:
      - 'null'
      - int
    doc: "Set maximum gap between clustered alignments [-1, INT_MAX]; -1 represents infinity (nucmer default = 1000, promer default = -1)"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Set minimum percent identity to tile [0.0, 100.0] (nucmer default = 90.0, promer default = 55.0)"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Set minimum length contig to report [-1, INT_MAX]; -1 represents infinity (common default = 1)"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: pseudo_molecule
    type:
      - 'null'
      - string
    doc: "Output a pseudo molecule of the query contigs to this file"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: random_repeats
    type:
      - 'null'
      - boolean
    doc: "Deal with repetitive contigs by randomly placing them in one of their copy locations (implies -V 0)"
    inputBinding:
      position: 1
      prefix: "-R"
  - id: tigr_contigs
    type:
      - 'null'
      - string
    doc: "Output a TIGR style contig list of each query sequence that sufficiently matches the reference (non-circular) to this file"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: unusable
    type:
      - 'null'
      - string
    doc: "Output the tab-delimited alignment region coordinates of the unusable contigs to this file"
    inputBinding:
      position: 1
      prefix: "-u"
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: "Set minimum contig coverage to tile [0.0, 100.0] (nucmer default = 95.0, promer default = 50.0)"
    inputBinding:
      position: 1
      prefix: "-v"
  - id: min_coverage_diff
    type:
      - 'null'
      - float
    doc: "Set minimum contig coverage difference [0.0, 100.0], i.e. the difference needed to determine one alignment is better than another (nucmer default = 10.0, promer default = 30.0)"
    inputBinding:
      position: 1
      prefix: "-V"
  - id: xml
    type:
      - 'null'
      - boolean
    doc: "Describe the tiling path by printing the XML contig linking information to stdout"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: delta_file
    type: File
    doc: "Delta alignment file from nucmer (very similar sequences) or promer (divergent sequences)"
    inputBinding:
      position: 100
  - id: reference
    type: File
    doc: "The delta file records the absolute path of this sequence file, so it is staged in the working directory /data, the same place nucmer or promer used. Reference sequence file named in the delta file."
  - id: query
    type: File
    doc: "The delta file records the absolute path of this sequence file, so it is staged in the working directory /data, the same place nucmer or promer used. Query (contig) sequence file named in the delta file."
outputs:
  - id: stdout_out
    type: stdout
    doc: "Predicted location of each aligning query contig as mapped to the reference sequences (start in ref, end in ref, distance to next contig, contig length, alignment coverage, identity, orientation, ID)"
  - id: pseudo_molecule_out
    type:
      - 'null'
      - File
    doc: "Pseudo molecule of the query contigs"
    outputBinding:
      glob: "$(inputs.pseudo_molecule)"
  - id: tigr_contigs_out
    type:
      - 'null'
      - File
    doc: "TIGR style contig list"
    outputBinding:
      glob: "$(inputs.tigr_contigs)"
  - id: unusable_out
    type:
      - 'null'
      - File
    doc: "Coordinates of the unusable contigs"
    outputBinding:
      glob: "$(inputs.unusable)"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
stdout: mummer_show-tiling.tiling
stderr: mummer_show-tiling.log
