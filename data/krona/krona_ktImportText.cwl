cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportText
label: krona_ktImportText
doc: "Creates a Krona chart from text files listing quantities and lineages.\n\nTool
  homepage: https://github.com/marbl/Krona"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Tab-delimited text file. Each line should be a number followed by a 
      list of wedges to contribute to (starting from the highest level). If no 
      wedges are listed (and just a quantity is given), it will contribute to 
      the top level. If the same lineage is listed more than once, the values 
      will be added. Quantities can be omitted if -q is specified. Lines 
      beginning with "#" will be ignored. By default, separate datasets will be 
      created for each input (see [-c]).
    inputBinding:
      position: 1
  - id: combine_datasets
    type:
      - 'null'
      - boolean
    doc: Combine data from each file, rather than creating separate datasets 
      within the chart.
    inputBinding:
      position: 102
      prefix: -c
  - id: highest_level_name
    type:
      - 'null'
      - string
    doc: Name of the highest level.
    inputBinding:
      position: 102
      prefix: -n
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart 
      (e.g. "http://krona.sourceforge.net"). Reduces size of charts and allows 
      updates, though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: no_quantity_field
    type:
      - 'null'
      - boolean
    doc: Files do not have a field for quantity.
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
