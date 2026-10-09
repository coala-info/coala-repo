cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-convertNR
label: kaiju_kaiju-convertNR
doc: "Convert an NCBI NR protein FASTA file into the FASTA format used to build a kaiju database (headers carry the taxon ID).\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: nodes_file
    type: File
    doc: Name of nodes.dmp file.
    inputBinding:
      position: 1
      prefix: -t
  - id: merged_file
    type: File
    doc: Name of merged.dmp file.
    inputBinding:
      position: 2
      prefix: -m
  - id: accession2taxid_file
    type: File
    doc: Name of prot.accession2taxid file.
    inputBinding:
      position: 3
      prefix: -g
  - id: output_file_path
    type: string
    doc: Name of output file.
    inputBinding:
      position: 4
      prefix: -o
  - id: prefix_accession
    type:
      - 'null'
      - boolean
    doc: Prefix taxon ID in database names with the first accession number per record.
    inputBinding:
      position: 5
      prefix: -a
  - id: nr_file
    type:
      - 'null'
      - File
    doc: Name of NR file. If this option is not used, then the program will read from STDIN.
    inputBinding:
      position: 6
      prefix: -i
  - id: taxon_list_file
    type:
      - 'null'
      - File
    doc: Name of file with taxon IDs. Only records having one of these IDs as ancestor in the taxonomy will be used.
    inputBinding:
      position: 7
      prefix: -l
  - id: excluded_accessions_file
    type:
      - 'null'
      - File
    doc: Name of file with accession numbers that will be excluded.
    inputBinding:
      position: 8
      prefix: -e
outputs:
  - id: output_file
    type: File
    doc: FASTA file for building a kaiju database
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-convertNR.out
