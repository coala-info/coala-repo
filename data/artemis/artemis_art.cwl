cwlVersion: v1.2
class: CommandLineTool
baseCommand: art
label: artemis_art
doc: "Artemis: Genome Browser and Annotation Tool\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs:
  - id: sequence_file
    type: File
    doc: An EMBL, GenBank, FASTA, or GFF3 file
    inputBinding:
      position: 1
  - id: feature_files
    type:
      - 'null'
      - type: array
        items: File
    doc: An Artemis TAB file, or GFF file
    inputBinding:
      position: 2
  - id: bam_clone
    type:
      - 'null'
      - int
    doc: Open all BAM, CRAM, VCF or BCF files in multiple (n > 1) panels
    inputBinding:
      position: 103
      prefix: -DbamClone
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Open one or more BAM, CRAM, VCF or BCF files
    inputBinding:
      position: 103
      prefix: -Dbam
  - id: bam_separate_panels
    type:
      - 'null'
      - type: array
        items: File
    doc: Open BAM, CRAM, VCF or BCF files in separate panels
    inputBinding:
      position: 103
      prefix: -Dbam[1,2,..]
  - id: black_belt_mode
    type:
      - 'null'
      - boolean
    doc: Keep warning messages to a minimum
    inputBinding:
      position: 103
      prefix: -Dblack_belt_mode
  - id: chado
    type:
      - 'null'
      - boolean
    doc: Connect to a Chado database (using PGHOST, PGPORT, PGDATABASE, PGUSER 
      environment variables)
    inputBinding:
      position: 103
      prefix: -chado
  - id: chado_database
    type:
      - 'null'
      - string
    doc: Get Artemis to open this CHADO database
    inputBinding:
      position: 103
      prefix: -Dchado
  - id: loguserplot
    type:
      - 'null'
      - type: array
        items: File
    doc: Open one or more userplots, take log(data)
    inputBinding:
      position: 103
      prefix: -Dloguserplot
  - id: offset
    type:
      - 'null'
      - int
    doc: Open viewer at base position XXX
    inputBinding:
      position: 103
      prefix: -Doffset
  - id: options_file
    type:
      - 'null'
      - File
    doc: Read a text file of options from FILE
    inputBinding:
      position: 103
      prefix: -options
  - id: read_only
    type:
      - 'null'
      - boolean
    doc: Open CHADO database read-only
    inputBinding:
      position: 103
      prefix: -Dread_only
  - id: show_cov_plot
    type:
      - 'null'
      - boolean
    doc: Open coverage plot in BamView
    inputBinding:
      position: 103
      prefix: -Dshow_cov_plot
  - id: show_forward_lines
    type:
      - 'null'
      - boolean
    doc: Hide/show forward frame lines
    inputBinding:
      position: 103
      prefix: -Dshow_forward_lines
  - id: show_reverse_lines
    type:
      - 'null'
      - boolean
    doc: Hide/show reverse frame lines
    inputBinding:
      position: 103
      prefix: -Dshow_reverse_lines
  - id: show_snp_plot
    type:
      - 'null'
      - boolean
    doc: Open SNP plot in BamView
    inputBinding:
      position: 103
      prefix: -Dshow_snp_plot
  - id: show_snps
    type:
      - 'null'
      - boolean
    doc: Show SNP marks in BamView
    inputBinding:
      position: 103
      prefix: -Dshow_snps
  - id: userplot
    type:
      - 'null'
      - type: array
        items: File
    doc: Open one or more userplots
    inputBinding:
      position: 103
      prefix: -Duserplot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_art.out
