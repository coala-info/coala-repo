cwlVersion: v1.2
class: CommandLineTool
baseCommand: strain_transmission.py
label: metaphlan_strain_transmission
doc: "Infer strain transmission events from a StrainPhlAn tree and the sample metadata.\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
      - entry: $(inputs.tree)
        writable: true
inputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: "The input tree file (staged writable: the distance table is written beside it)"
    inputBinding:
      position: 101
      prefix: "--tree"
      valueFrom: "$(self.basename)"
  - id: metadata
    type:
      - 'null'
      - File
    doc: "The input metadata"
    inputBinding:
      position: 101
      prefix: "--metadata"
  - id: output_dir
    type: string
    doc: "The output directory (created before the run)"
    inputBinding:
      position: 101
      prefix: "--output_dir"
  - id: sgb_id
    type:
      - 'null'
      - string
    doc: "[Optional] If specified, it will use the precomputed transmission threshold for the specific SGB from the VallesColomerM_2022 study"
    inputBinding:
      position: 101
      prefix: "--sgb_id"
  - id: threshold
    type:
      - 'null'
      - float
    doc: "[Optional] A custom distribution threshold value (default: 0.03)"
    inputBinding:
      position: 101
      prefix: "--threshold"
  - id: precomputed_thresholds_file
    type:
      - 'null'
      - File
    doc: "[Optional] The file containing the pre-computed thresholds"
    inputBinding:
      position: 101
      prefix: "--precomputed_thresholds_file"
  - id: save_dist
    type:
      - 'null'
      - boolean
    doc: "[Optional] Save the PhyPhlAn pairwise distances file"
    inputBinding:
      position: 101
      prefix: "--save_dist"
outputs:
  - id: transmission_dir
    type: Directory
    doc: "Output folder with the transmission events"
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_strain_transmission.out
