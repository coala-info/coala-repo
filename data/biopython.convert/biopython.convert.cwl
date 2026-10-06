cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopython.convert
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
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 3
  - id: output_type
    type: string
    doc: Format of the output file (e.g., fasta, genbank, fastq, etc.)
    inputBinding:
      position: 4
  - id: print_details
    type:
      - 'null'
      - boolean
    doc: Print out details of records during conversion (GFF3 summary on standard
      output)
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
    doc: Split records into seperate files (adds an index before the output file
      extension, e.g. out.0.fasta)
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Converted output file (absent when records are split)
    outputBinding:
      glob: $(inputs.output_file_name)
  - id: split_files
    type: File[]
    doc: One output file per record when split_records is set
    outputBinding:
      glob: "${\n  var n = inputs.output_file_name;\n  var i = n.lastIndexOf('.');\n\
        \  return i > 0 ? n.substring(0, i) + '.[0-9]*' + n.substring(i) : n + '.[0-9]*';\n\
        }"
  - id: details
    type: stdout
    doc: Record details printed with print_details
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopython.convert:1.3.3--pyh5e36f6f_0
stdout: biopython.convert.details.txt
