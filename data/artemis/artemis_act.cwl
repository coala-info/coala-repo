cwlVersion: v1.2
class: CommandLineTool
baseCommand: act
label: artemis_act
doc: "Genome Comparison Tool\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs:
  - id: sequence_1
    type: File
    doc: An EMBL, GenBank, FASTA, or GFF3 file
    inputBinding:
      position: 1
  - id: comparison_1_2
    type: File
    doc: A BLAST comparison file in tabular format
    inputBinding:
      position: 2
  - id: sequence_2
    type: File
    doc: An EMBL, GenBank, FASTA, or GFF3 file
    inputBinding:
      position: 3
  - id: bam_x
    type:
      - 'null'
      - type: array
        items: File
    doc: For sequence 'X' open one or more BAM, CRAM, VCF, or BCF files
    inputBinding:
      position: 104
      prefix: -DbamX
  - id: black_belt_mode
    type:
      - 'null'
      - boolean
    doc: Keep warning messages to a minimum
    inputBinding:
      position: 104
      prefix: -Dblack_belt_mode
  - id: chado
    type:
      - 'null'
      - boolean
    doc: Connect to a Chado database (using PGHOST, PGPORT, PGDATABASE, PGUSER 
      environment variables)
    inputBinding:
      position: 104
      prefix: -chado
  - id: chado_db_connection
    type:
      - 'null'
      - string
    doc: Get ACT to open this CHADO database
    inputBinding:
      position: 104
      prefix: -Dchado
  - id: loguserplot_x
    type:
      - 'null'
      - type: array
        items: string
    doc: For sequence 'X' open one or more userplots, take log(data)
    inputBinding:
      position: 104
      prefix: -DloguserplotX
  - id: options_file
    type:
      - 'null'
      - File
    doc: Read a text file of options from FILE
    inputBinding:
      position: 104
      prefix: -options
  - id: read_only
    type:
      - 'null'
      - boolean
    doc: Open CHADO database read-only
    inputBinding:
      position: 104
      prefix: -Dread_only
  - id: userplot_x
    type:
      - 'null'
      - type: array
        items: string
    doc: For sequence 'X' open one or more userplots
    inputBinding:
      position: 104
      prefix: -DuserplotX
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_act.out
