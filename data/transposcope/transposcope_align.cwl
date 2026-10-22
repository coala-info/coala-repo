cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transposcope
  - align
label: transposcope_align
doc: "Align performs a local realignment using reads flanking a potential insertion site and a reference sequence which includes the sequence for the mobile element\n\nTool homepage: https://github.com/FenyoLab/transposcope"
inputs:
  - id: software
    type: string
    doc: "The software used to identify insertions (melt or tipseqhunter)"
    inputBinding:
      position: 1
  - id: index
    type: File
    doc: The path to the index file which describes the coordinates of insertion sites
    inputBinding:
      position: 2
  - id: bam
    type: File
    doc: path to bam file
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 3
  - id: me_reference
    type: File
    doc: path to the mobile element's FASTA file
    inputBinding:
      position: 4
  - id: host_reference
    type: Directory
    doc: path to a folder containing all of the chromosome FASTA files for the host genome
    inputBinding:
      position: 5
  - id: sample_id
    type: string
    doc: Unique name to for the given experiment. This is used to label the output.
    inputBinding:
      position: 6
  - id: genes
    type:
      - 'null'
      - File
    doc: Path to refFlat.txt (If information regarding the nearest gene should be included.)
    inputBinding:
      prefix: --genes
  - id: group1
    type:
      - 'null'
      - string
    doc: "First level group tag (default: ungrouped)"
    inputBinding:
      prefix: --group1
  - id: group2
    type:
      - 'null'
      - string
    doc: "Second level group tag (default: ungrouped)"
    inputBinding:
      prefix: --group2
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: "Flag which determines whether intermediate bam files and fasta files are deleted (default: False)"
    inputBinding:
      prefix: --keep_files
outputs:
  - id: web_directory
    type:
      - 'null'
      - Directory
    doc: Output directory with the realigned data for viewing (named after the sample id)
    outputBinding:
      glob: $(inputs.sample_id)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transposcope:2.0.1--py_0
