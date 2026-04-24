cwlVersion: v1.2
class: CommandLineTool
baseCommand: viromeQC.py
label: viromeqc_viromeQC.py
doc: "Checks a virome FASTQ file for enrichment efficiency\n\nTool homepage: https://github.com/SegataLab/viromeqc"
inputs:
  - id: bowtie2_path
    type:
      - 'null'
      - string
    doc: Full path to the bowtie2 command to use, deafult assumes that 'bowtie2 
      is present in the system path
    inputBinding:
      position: 101
      prefix: --bowtie2_path
  - id: bowtie2_threads
    type:
      - 'null'
      - int
    doc: Number of Threads to use with Bowtie2
    inputBinding:
      position: 101
      prefix: --bowtie2_threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Prints error messages in case of debug
    inputBinding:
      position: 101
      prefix: --debug
  - id: diamond_path
    type:
      - 'null'
      - string
    doc: Full path to the diamond command to use, deafult assumes that 'diamond 
      is present in the system path
    inputBinding:
      position: 101
      prefix: --diamond_path
  - id: diamond_threads
    type:
      - 'null'
      - int
    doc: Number of Threads to use with Diamond
    inputBinding:
      position: 101
      prefix: --diamond_threads
  - id: enrichment_preset
    type:
      - 'null'
      - string
    doc: 'Calculate the enrichment basing on human or environmental metagenomes. Defualt:
      human-microbiome'
    inputBinding:
      position: 101
      prefix: --enrichment_preset
  - id: input
    type:
      type: array
      items: File
    doc: Raw Reads in FASTQ format. Supports multiple inputs (plain, gz o bz2)
    inputBinding:
      position: 101
      prefix: --input
  - id: install
    type:
      - 'null'
      - boolean
    doc: Downloads database files
    inputBinding:
      position: 101
      prefix: --install
  - id: medians
    type:
      - 'null'
      - File
    doc: File containing reference medians to calculate the enrichment. Default 
      is medians.csv in the script directory. You can specify a different file 
      with this parameter.
    inputBinding:
      position: 101
      prefix: --medians
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum Read Length allowed
    inputBinding:
      position: 101
      prefix: --minlen
  - id: minlen_lsu
    type:
      - 'null'
      - int
    doc: Minimum alignment length when considering LSU rRNA gene
    inputBinding:
      position: 101
      prefix: --minlen_LSU
  - id: minlen_ssu
    type:
      - 'null'
      - int
    doc: Minimum alignment length when considering SSU rRNA gene
    inputBinding:
      position: 101
      prefix: --minlen_SSU
  - id: minqual
    type:
      - 'null'
      - int
    doc: Minimum Read Average Phred quality
    inputBinding:
      position: 101
      prefix: --minqual
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Optional label for the sample to be included in the output file
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Temporary Directory override (default is the system temp directory)
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: zenodo
    type:
      - 'null'
      - boolean
    doc: Use Zenodo instead of Dropbox to download the DB
    inputBinding:
      position: 101
      prefix: --zenodo
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viromeqc:1.0.2--py310h7cba7a3_0
