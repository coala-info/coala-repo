cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - arcasHLA
  - extract
label: arcas-hla_extract
doc: "Extract chromosome 6 reads (and HLA decoys/alts) from a BAM file to FASTQ\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam)
        writable: true
inputs:
  - id: bam
    type: File
    doc: "/path/to/sample.bam (staged writable: the tool indexes it in place)"
    inputBinding:
      position: 10
  - id: log
    type:
      - 'null'
      - string
    doc: "log file for run summary (default: sample.extract.log in the out directory)"
    inputBinding:
      position: 1
      prefix: --log
  - id: single
    type:
      - 'null'
      - boolean
    doc: "single-end reads"
    inputBinding:
      position: 1
      prefix: --single
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: "include unmapped reads"
    inputBinding:
      position: 1
      prefix: --unmapped
  - id: allreads
    type:
      - 'null'
      - boolean
    doc: "output all reads to fastq"
    inputBinding:
      position: 1
      prefix: --allreads
  - id: outdir
    type: string
    doc: out directory
    default: extracted
    inputBinding:
      position: 1
      prefix: --outdir
  - id: temp
    type:
      - 'null'
      - string
    doc: "temp directory"
    inputBinding:
      position: 1
      prefix: --temp
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: "keep intermediate files"
    inputBinding:
      position: 1
      prefix: --keep_files
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads"
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: fastq
    type: File[]
    doc: Extracted reads (sample.extracted.1.fq.gz and .2.fq.gz, or sample.extracted.fq.gz for single-end)
    outputBinding:
      glob: $(inputs.outdir)/*.fq.gz
  - id: log_file
    type: File?
    doc: Run summary log
    outputBinding:
      glob: '$(inputs.log ? inputs.log : inputs.outdir + "/*.extract.log")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
