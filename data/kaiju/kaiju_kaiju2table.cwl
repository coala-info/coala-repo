cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju2table
label: kaiju_kaiju2table
doc: "Summarize one or more kaiju outputs as a table of read counts per taxon at a chosen rank.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: output_file_path
    type: string
    doc: "Name of output file."
    inputBinding:
      position: 1
      prefix: -o
  - id: nodes_file
    type: File
    doc: "Name of nodes.dmp file"
    inputBinding:
      position: 2
      prefix: -t
  - id: names_file
    type: File
    doc: "Name of names.dmp file"
    inputBinding:
      position: 3
      prefix: -n
  - id: rank
    type: string
    doc: "Taxonomic rank, must be one of: phylum, class, order, family, genus, species"
    inputBinding:
      position: 4
      prefix: -r
  - id: min_percent
    type:
      - 'null'
      - float
    doc: "Number in [0, 100], denoting the minimum required percentage for the taxon (except viruses) to be reported (default: 0.0)"
    inputBinding:
      position: 5
      prefix: -m
  - id: min_reads
    type:
      - 'null'
      - int
    doc: "Integer number > 0, denoting the minimum required number of reads for the taxon (except viruses) to be reported (default: 0)"
    inputBinding:
      position: 6
      prefix: -c
  - id: expand_viruses
    type:
      - 'null'
      - boolean
    doc: "Expand viruses, which are always shown as full taxon path and read counts are not summarized in higher taxonomic levels."
    inputBinding:
      position: 7
      prefix: -e
  - id: exclude_unclassified
    type:
      - 'null'
      - boolean
    doc: "Unclassified reads are not counted for the total reads when calculating percentages for classified reads."
    inputBinding:
      position: 8
      prefix: -u
  - id: full_path
    type:
      - 'null'
      - boolean
    doc: "Print full taxon path."
    inputBinding:
      position: 9
      prefix: -p
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Print taxon path containing only ranks specified by a comma-separated list, for example: superkingdom,phylum,class,order,family,genus,species"
    inputBinding:
      position: 10
      prefix: -l
      itemSeparator: ','
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output."
    inputBinding:
      position: 11
      prefix: -v
  - id: input_files
    type:
      type: array
      items: File
    doc: "Kaiju output files (one table column per file)"
    inputBinding:
      position: 100
outputs:
  - id: output_file
    type: File
    doc: "Summary table"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju2table.out
