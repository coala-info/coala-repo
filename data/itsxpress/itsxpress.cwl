cwlVersion: v1.2
class: CommandLineTool
baseCommand: itsxpress
label: itsxpress
doc: "ITSxpress: A python module to rapidly trim ITS amplicon sequences from Fastq
  files.\n\nTool homepage: http://github.com/usda-ars-gbru/itsxpress"
inputs:
  - id: fastq
    type: File
    doc: A .fastq, .fq, .fastq.gz or .fq.gz file. Interleaved or not.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: A flag to specify that the FASTQ file is single-ended (not paired). Default is false.
    inputBinding:
      position: 101
      prefix: --single_end
  - id: fastq2
    type:
      - 'null'
      - File
    doc: A .fastq, .fq, .fastq.gz or .fq.gz file. representing read 2 (optional)
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: outfile
    type: string
    doc: the trimmed Fastq file, if it ends in 'gz' it will be gzipped
    inputBinding:
      position: 101
      prefix: --outfile
  - id: outfile2
    type:
      - 'null'
      - string
    doc: the trimmed read 2 Fastq file, if it ends in 'gz' it will be gzipped. If provided, reads will be returned unmerged.
    inputBinding:
      position: 101
      prefix: --outfile2
  - id: tempdir
    type:
      - 'null'
      - string
    doc: The temp file directory
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: allow_staggered_reads
    type:
      - 'null'
      - string
    doc: Allow merging of staggered reads with --fastq_allowmergestagger for Vsearch
      --fastq_mergepairs. See Vsearch documentation. (Optional) Default is true.
    inputBinding:
      position: 101
      prefix: --allow_staggered_reads
  - id: keeptemp
    type:
      - 'null'
      - boolean
    doc: Should intermediate files be kept?
    inputBinding:
      position: 101
      prefix: --keeptemp
  - id: region
    type:
      type: enum
      symbols:
        - ITS2
        - ITS1
        - ALL
    doc: The ITS region to extract
    inputBinding:
      position: 101
      prefix: --region
  - id: taxa
    type:
      - 'null'
      - type: enum
        symbols:
          - Alveolata
          - Bryophyta
          - Bacillariophyta
          - Amoebozoa
          - Euglenozoa
          - Fungi
          - Chlorophyta
          - Rhodophyta
          - Phaeophyceae
          - Marchantiophyta
          - Metazoa
          - Oomycota
          - Haptophyceae
          - Raphidophyceae
          - Rhizaria
          - Synurophyceae
          - Tracheophyta
          - Eustigmatophyceae
          - Parabasalia
          - All
    doc: The taxonomic group sequenced.
    inputBinding:
      position: 101
      prefix: --taxa
  - id: cluster_id
    type:
      - 'null'
      - float
    doc: The percent identity for clustering reads range [0.99-1.0], set to 1 for exact dereplication.
    inputBinding:
      position: 101
      prefix: --cluster_id
  - id: reversed_primers
    type:
      - 'null'
      - boolean
    doc: Primers are in reverse orientation as in Taylor et al. 2016, DOI:10.1128/AEM.02576-16.
      If selected ITSxpress returns trimmed reads flipped to the forward orientation
    inputBinding:
      position: 101
      prefix: --reversed_primers
  - id: log
    type:
      - 'null'
      - string
    doc: Log file
    inputBinding:
      position: 101
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processor threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: trimmed_reads
    type: File
    doc: Trimmed FASTQ file
    outputBinding:
      glob: $(inputs.outfile)
  - id: trimmed_reads2
    type:
      - 'null'
      - File
    doc: Trimmed read 2 FASTQ file (only with outfile2)
    outputBinding:
      glob: $(inputs.outfile2)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itsxpress:2.1.4--pyhdfd78af_0
