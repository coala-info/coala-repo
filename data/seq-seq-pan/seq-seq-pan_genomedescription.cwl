cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq-seq-pan-genomedescription
label: seq-seq-pan_genomedescription
doc: "Write a genome description file (genome id, name and length for each sequence)
  from a list of FASTA files.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: genome_list
    type: File
    doc: File with list of /paths/to/files.fasta
    inputBinding:
      position: 1
      prefix: --input
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA files named in the genome list. They are staged in the working
      directory so that names in the list resolve.
  - id: output_file
    type: string
    doc: name of output file
    default: genomedescription.txt
    inputBinding:
      position: 2
      prefix: --output
  - id: add_file
    type:
      - 'null'
      - File
    doc: Add new genome description to this file.
    inputBinding:
      position: 3
      prefix: --add
outputs:
  - id: genome_description
    type: File
    doc: Genome description file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: ${ return inputs.genome_files || []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
