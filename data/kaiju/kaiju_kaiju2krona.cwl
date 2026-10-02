cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/kaiju2krona
label: kaiju_kaiju2krona
doc: Convert Kaiju output to Krona format
inputs:
  - id: input_file
    type: File
    doc: Name of input file
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file
    type: string
    doc: Name of output file.
    inputBinding:
      position: 101
      prefix: -o
  - id: nodes_file
    type:
      - 'null'
      - File
    doc: Name of nodes.dmp file
    inputBinding:
      position: 101
      prefix: -t
  - id: names_file
    type:
      - 'null'
      - File
    doc: Name of names.dmp file
    inputBinding:
      position: 101
      prefix: -n
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Print taxon path containing only ranks specified by a comma-separated list,
      for example: superkingdom,phylum,class,order,family,genus,species'
    inputBinding:
      position: 101
      prefix: -l
      itemSeparator: ','
  - id: unclassified
    type:
      - 'null'
      - boolean
    doc: Include count for unclassified reads in output.
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: output_output_file
    type: File
    doc: Name of output file.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
s:url: https://github.com/bioinformatics-centre/kaiju
$namespaces:
  s: https://schema.org/
