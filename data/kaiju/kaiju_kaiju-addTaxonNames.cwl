cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-addTaxonNames
label: kaiju_kaiju-addTaxonNames
doc: "Add taxon names (or full taxon paths) to a kaiju output file.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: input_file
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file_path
    type: string
    doc: "Name of output file."
    inputBinding:
      position: 2
      prefix: -o
  - id: nodes_file
    type: File
    doc: "Name of nodes.dmp file"
    inputBinding:
      position: 3
      prefix: -t
  - id: names_file
    type: File
    doc: "Name of names.dmp file"
    inputBinding:
      position: 4
      prefix: -n
  - id: no_unclassified
    type:
      - 'null'
      - boolean
    doc: "Unclassified reads are not contained in the output."
    inputBinding:
      position: 5
      prefix: -u
  - id: full_path
    type:
      - 'null'
      - boolean
    doc: "Print full taxon path."
    inputBinding:
      position: 6
      prefix: -p
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Print taxon path containing only ranks specified by a comma-separated list, for example: superkingdom,phylum,class,order,family,genus,species"
    inputBinding:
      position: 7
      prefix: -r
      itemSeparator: ','
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output."
    inputBinding:
      position: 8
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: "Kaiju output with taxon names"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-addTaxonNames.out
