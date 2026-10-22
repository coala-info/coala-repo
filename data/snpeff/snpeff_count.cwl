cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - count
label: snpeff_count
doc: "Count how many intervals (from BAM, SAM, VCF, BED or BigBed files) fall into each genomic region of the database.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "Output file base name."
    inputBinding:
      position: 1
      prefix: -n
  - id: prob_model
    type:
      - 'null'
      - boolean
    doc: "Calculate probability model (binomial). Default: false"
    inputBinding:
      position: 1
      prefix: -p
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
  - id: files
    type:
      type: array
      items: File
    doc: "A file containing intervals or reads. Either BAM, SAM, VCF, BED or BigBed format."
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
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Only use canonical transcripts.
    inputBinding:
      position: 104
      prefix: -canon
  - id: canonical_list_file
    type:
      - 'null'
      - File
    doc: "Only use canonical transcripts, replace some transcripts using the 'gene_id
      \t transcript_id' entries in <file>."
    inputBinding:
      position: 104
      prefix: -canonList
  - id: interaction
    type:
      - 'null'
      - boolean
    doc: 'Annotate using interactions (requires interaction database). Default: true'
    inputBinding:
      position: 104
      prefix: -interaction
  - id: max_transcript_support_level
    type:
      - 'null'
      - int
    doc: Only use transcripts having Transcript Support Level lower than 
      <TSL_number>.
    inputBinding:
      position: 104
      prefix: -maxTSL
  - id: motif
    type:
      - 'null'
      - boolean
    doc: 'Annotate using motifs (requires Motif database). Default: true'
    inputBinding:
      position: 104
      prefix: -motif
  - id: next_prot
    type:
      - 'null'
      - boolean
    doc: Annotate using NextProt (requires NextProt database).
    inputBinding:
      position: 104
      prefix: -nextProt
  - id: no_genome
    type:
      - 'null'
      - boolean
    doc: Do not load any genomic database (e.g. annotate using custom files).
    inputBinding:
      position: 104
      prefix: -noGenome
  - id: no_expand_iub
    type:
      - 'null'
      - boolean
    doc: Disable IUB code expansion in input variants
    inputBinding:
      position: 104
      prefix: -noExpandIUB
  - id: no_interaction
    type:
      - 'null'
      - boolean
    doc: Disable inteaction annotations
    inputBinding:
      position: 104
      prefix: -noInteraction
  - id: no_motif
    type:
      - 'null'
      - boolean
    doc: Disable motif annotations.
    inputBinding:
      position: 104
      prefix: -noMotif
  - id: no_next_prot
    type:
      - 'null'
      - boolean
    doc: Disable NextProt annotations.
    inputBinding:
      position: 104
      prefix: -noNextProt
  - id: only_reg
    type:
      - 'null'
      - boolean
    doc: Only use regulation tracks.
    inputBinding:
      position: 104
      prefix: -onlyReg
  - id: only_protein
    type:
      - 'null'
      - boolean
    doc: 'Only use protein coding transcripts. Default: false'
    inputBinding:
      position: 104
      prefix: -onlyProtein
  - id: only_transcripts_file
    type:
      - 'null'
      - File
    doc: 'Only use the transcripts in this file. Format: One transcript ID per line.'
    inputBinding:
      position: 104
      prefix: -onlyTr
  - id: splice_region_exon_size
    type:
      - 'null'
      - int
    doc: 'Set size for splice site region within exons. Default: 3 bases'
    inputBinding:
      position: 104
      prefix: -spliceRegionExonSize
  - id: splice_region_intron_max
    type:
      - 'null'
      - int
    doc: 'Set maximum number of bases for splice site region within intron. Default:
      8 bases'
    inputBinding:
      position: 104
      prefix: -spliceRegionIntronMax
  - id: splice_region_intron_min
    type:
      - 'null'
      - int
    doc: 'Set minimum number of bases for splice site region within intron. Default:
      3 bases'
    inputBinding:
      position: 104
      prefix: -spliceRegionIntronMin
  - id: splice_site_size
    type:
      - 'null'
      - int
    doc: 'Set size for splice sites (donor and acceptor) in bases. Default: 2'
    inputBinding:
      position: 104
      prefix: -ss
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -tag
          separate: true
    doc: Only use transcript having a tag 'tagName'. This option can be used 
      multiple times.
    inputBinding:
      position: 104
  - id: no_tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -notag
          separate: true
    doc: Filter out transcript having a tag 'tagName'. This option can be used 
      multiple times.
    inputBinding:
      position: 104
  - id: custom_intervals_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -interval
          separate: true
    doc: Use a custom intervals in TXT/BED/BigBed/VCF/GFF file (you may use this
      option many times)
    inputBinding:
      position: 104
  - id: regulation_track
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -reg
          separate: true
    doc: Regulation track to use (this option can be used add several times).
    inputBinding:
      position: 104
  - id: up_down_stream_len
    type:
      - 'null'
      - int
    doc: Set upstream downstream interval length (in bases)
    inputBinding:
      position: 104
      prefix: -ud
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
  - id: count_files
    type:
      type: array
      items: File
    doc: Count tables written with the base name (or the default name)
    outputBinding:
      glob: "$(inputs.name ? inputs.name + '*' : 'count*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_count.out
stderr: snpeff_count.err
