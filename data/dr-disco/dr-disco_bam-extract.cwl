cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - bam-extract
label: dr-disco_bam-extract
doc: "Extract reads from two chromosomal positions (and also take the mates with the same name) - regions are in the format chr1:123-546.\n\nTool homepage:
  https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: region1
    type: string
    doc: The first region to extract reads from.
    inputBinding:
      position: 1
  - id: region2
    type: string
    doc: The second region to extract reads from.
    inputBinding:
      position: 2
  - id: bam_input_file
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: The input BAM file.
    inputBinding:
      position: 3
  - id: bam_output_file
    type: string
    doc: The output BAM file.
    inputBinding:
      position: 4
  - id: restrict_to_targeted_chromosomes
    type:
      - 'null'
      - boolean
    doc: Excludes reads of which a piece was aligned to other chromosomes than 
      requested by the regions.
    inputBinding:
      position: 104
      prefix: --restrict-to-targeted-chromosomes
outputs:
  - id: out_bam_output_file
    type: File
    doc: The output BAM file.
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: '$(inputs.bam_output_file)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam_input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
