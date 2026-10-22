cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stringMLST.py
  - --predict
label: stringmlst_predict
doc: "Predict the sequence type (ST) of samples from sequencing reads using a stringMLST database. Runs on a single sample, a folder of samples (batch mode) or a list of samples (list mode).\n\nTool homepage: https://github.com/jordanlab/stringMLST"
inputs:
  - id: fastq1
    type:
      - 'null'
      - File
    doc: Path to first fastq file for paired end sample and path to the fastq file
      for single end file. Should have extension fastq or fq.
    inputBinding:
      position: 1
      prefix: --fastq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Path to second fastq file for paired end sample. Should have extension fastq
      or fq.
    inputBinding:
      position: 2
      prefix: --fastq2
  - id: directory
    type:
      - 'null'
      - Directory
    doc: 'BATCH MODE : Location of all the samples for batch mode.'
    inputBinding:
      position: 3
      prefix: --dir
  - id: list_file
    type:
      - 'null'
      - File
    doc: 'LIST MODE : list file with full file paths for all the samples. Each sample
      takes one line. For paired end samples the 2 files should be tab separated on
      single line.'
    inputBinding:
      position: 4
      prefix: --list
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Flag for specifying paired end files. Default option.
    inputBinding:
      position: 5
      prefix: --paired
  - id: single
    type:
      - 'null'
      - boolean
    doc: Flag for specifying single end files.
    inputBinding:
      position: 6
      prefix: --single
  - id: database_dir
    type: Directory
    doc: Directory holding the database files created by buildDB or getMLST (staged
      writable, because the tool writes its log next to the database prefix)
    inputBinding:
      position: 7
      prefix: --prefix
      valueFrom: $(self.basename + '/' + inputs.database_prefix)
  - id: database_prefix
    type: string
    doc: Prefix using which the db was created (file name prefix inside the database
      directory)
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer length for which the db was created (Default k = 35)
    inputBinding:
      position: 8
      prefix: -k
  - id: fuzzy
    type:
      - 'null'
      - int
    doc: Threshold for reporting a fuzzy match (Default=300)
    inputBinding:
      position: 9
      prefix: --fuzzy
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Calculate sequence coverage for each allele. Turns on read generation (-r)
      and turns off fuzzy (-z 1). Requires bwa, bamtools and samtools in the path.
    inputBinding:
      position: 10
      prefix: --coverage
  - id: reads_file
    type:
      - 'null'
      - boolean
    doc: A separate reads file is created which has all the reads covering all the
      locus.
    inputBinding:
      position: 11
      prefix: -r
  - id: time_report
    type:
      - 'null'
      - boolean
    doc: Time for each analysis will also be reported.
    inputBinding:
      position: 12
      prefix: -t
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the previously specified output file instead of appending.
    inputBinding:
      position: 13
      prefix: --overwrite
  - id: output_filename
    type: string
    doc: Prints the output to a file instead of stdout.
    inputBinding:
      position: 14
      prefix: --output
outputs:
  - id: predictions
    type: File
    doc: Predicted sequence types (tab separated table)
    outputBinding:
      glob: $(inputs.output_filename)
  - id: reads_out
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads covering the loci and coverage files written with -r or --coverage
    outputBinding:
      glob:
        - '*_reads.fq'
        - '*_reads*.fastq'
        - '*coverage*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database_dir.basename)
        entry: $(inputs.database_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmlst:0.6.3--py_0
