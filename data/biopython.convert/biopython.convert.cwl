cwlVersion: v1.2
class: CommandLineTool
baseCommand: biopython.convert
label: biopython.convert
doc: "Convert biological sequence files between different formats using Biopython.\n
  \nTool homepage: https://github.com/brinkmanlab/BioPython-Convert"
inputs:
  - id: input_file
    type: File
    doc: Input file to be converted
    inputBinding:
      position: 1
  - id: input_type
    type: string
    doc: Format of the input file (e.g., fasta, genbank, fastq, etc.)
    inputBinding:
      position: 2
  - id: output_type
    type: string
    doc: Format of the output file (e.g., fasta, genbank, fastq, etc.)
    inputBinding:
      position: 3
  - id: print_details
    type:
      - 'null'
      - boolean
    doc: Print out details of records during conversion
    inputBinding:
      position: 104
      prefix: -i
  - id: query
    type:
      - 'null'
      - string
    doc: JMESPath to select records. Must return list of SeqIO records. Root is list
      of input SeqIO records.
    inputBinding:
      position: 104
      prefix: -q
  - id: split_records
    type:
      - 'null'
      - boolean
    doc: Split records into seperate files
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopython.convert:1.3.3--pyh5e36f6f_0
