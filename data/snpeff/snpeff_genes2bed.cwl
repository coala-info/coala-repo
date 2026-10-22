cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - genes2bed
label: snpeff_genes2bed
doc: "Write the genomic intervals of genes (or exons, introns, transcripts) of a genome database as BED.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: cds
    type:
      - 'null'
      - boolean
    doc: "Show coding exons (no UTRs)."
    inputBinding:
      position: 1
      prefix: -cds
  - id: exons
    type:
      - 'null'
      - boolean
    doc: "Show exons for every transcript."
    inputBinding:
      position: 1
      prefix: -e
  - id: gene_list_file
    type:
      - 'null'
      - File
    doc: "A TXT file having one gene ID (or name) per line."
    inputBinding:
      position: 1
      prefix: -f
  - id: introns
    type:
      - 'null'
      - boolean
    doc: "Show introns for every transcript."
    inputBinding:
      position: 1
      prefix: -i
  - id: protein_coding
    type:
      - 'null'
      - boolean
    doc: "Use only protein coding genes."
    inputBinding:
      position: 1
      prefix: -pc
  - id: transcripts
    type:
      - 'null'
      - boolean
    doc: "Show transcript coordinates."
    inputBinding:
      position: 1
      prefix: -tr
  - id: up_down
    type:
      - 'null'
      - int
    doc: "Expand gene interval upstream and downstream by 'num' bases."
    inputBinding:
      position: 1
      prefix: -ud
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
  - id: gene_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of gene IDs or names, one per command line argument"
    inputBinding:
      position: 3
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify config file
    inputBinding:
      position: 104
      prefix: -c
  - id: config_option
    type:
      - 'null'
      - string
    doc: Override a config file option
    inputBinding:
      position: 104
      prefix: -configOption
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Override data_dir parameter from config file.
    inputBinding:
      position: 104
      prefix: -dataDir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode (very verbose).
    inputBinding:
      position: 104
      prefix: -d
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: Do not download a SnpEff database, if not available locally.
    inputBinding:
      position: 104
      prefix: -nodownload
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Do not report usage statistics to server
    inputBinding:
      position: 104
      prefix: -noLog
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode (do not show any messages or errors)
    inputBinding:
      position: 104
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_genes2bed.out
stderr: snpeff_genes2bed.err
