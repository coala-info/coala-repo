cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac-reorder-reference
label: isaac4_isaac-reorder-reference
doc: "Reorder the contigs of an Isaac sorted reference and write a new reference XML descriptor.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs:
  - id: reference_genome
    type: File
    doc: Full path to the reference genome XML descriptor (sorted-reference.xml)
    inputBinding:
      position: 101
      prefix: --reference-genome
  - id: order
    type:
      - 'null'
      - string
    doc: Comma-separated list of contig names in the order in which they will appear in the new .fa file
    inputBinding:
      position: 101
      prefix: --order
  - id: response_file
    type:
      - 'null'
      - File
    doc: file with more command line arguments
    inputBinding:
      position: 101
      prefix: --response-file
  - id: output_directory
    type: string
    doc: Path for the reordered fasta and annotation files
    inputBinding:
      position: 102
      prefix: --output-directory
  - id: output_xml
    type: string
    doc: Path for the new xml file
    inputBinding:
      position: 103
      prefix: --output-xml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type: Directory
    doc: Directory with the reordered fasta and annotation files
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_xml_file
    type:
      - 'null'
      - File
    doc: New reference xml descriptor
    outputBinding:
      glob: $(inputs.output_xml)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4_isaac-reorder-reference.out
