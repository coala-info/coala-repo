cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringmlst.py
label: stringmlst_stringMLST.py
doc: "Readme for stringMLST\n\nTool homepage: https://github.com/jordanlab/stringMLST"
inputs:
  - id: build_db
    type:
      - 'null'
      - boolean
    doc: Identifier for build db module
    inputBinding:
      position: 101
      prefix: --buildDB
  - id: build_log
    type:
      - 'null'
      - boolean
    doc: File location to write build log
    inputBinding:
      position: 101
  - id: config
    type:
      - 'null'
      - boolean
    doc: Config file in the format described above. All the files follow the 
      structure followed by pubmlst. Refer extended document for details.
    inputBinding:
      position: 101
      prefix: --config
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Calculate sequence coverage for each allele. Turns on read generation 
      (-r) and turns off fuzzy (-z 1) Requires bwa, bamtools and samtools be in 
      your path
    inputBinding:
      position: 101
      prefix: --coverage
  - id: directory
    type:
      - 'null'
      - Directory
    doc: 'BATCH MODE : Location of all the samples for batch mode.'
    inputBinding:
      position: 101
      prefix: --dir
  - id: fastq1
    type:
      - 'null'
      - File
    doc: Path to first fastq file for paired end sample and path to the fastq 
      file for single end file. Should have extension fastq or fq.
    inputBinding:
      position: 101
      prefix: --fastq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Path to second fastq file for paired end sample. Should have extension 
      fastq or fq.
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: fuzzy
    type:
      - 'null'
      - int
    doc: Threshold for reporting a fuzzy match (Default=300). For higher 
      coverage reads this threshold should be set higher to avoid indicating 
      fuzzy match when exact match was more likely. For lower coverage reads, 
      threshold of <100 is recommended
    inputBinding:
      position: 101
      prefix: --fuzzy
  - id: get_mlst
    type:
      - 'null'
      - boolean
    doc: Identifier for getMLST module
    inputBinding:
      position: 101
      prefix: --getMLST
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer size for which the db has to be formed(Default k = 35). Note the 
      tool works best with kmer length in between 35 and 66 for read lengths of 
      55 to 150 bp. Kmer size can be increased accordingly. It is advised to 
      keep lower kmer sizes if the quality of reads is not very good.
    inputBinding:
      position: 101
      prefix: -k
  - id: list_file
    type:
      - 'null'
      - File
    doc: 'LIST MODE : Location of list file and flag for list mode. list file should
      have full file paths for all the samples/files. Each sample takes one line.
      For paired end samples the 2 files should be tab separated on single line.'
    inputBinding:
      position: 101
      prefix: --list
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: By default stringMLST appends the results to the output_filename if 
      same name is used. This argument overwrites the previously specified 
      output file.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Flag for specifying paired end files. Default option so would work the 
      same if you do not specify for all modes. For batch mode the paired end 
      samples should be differentiated by 1/2.fastq or 1/2.fq
    inputBinding:
      position: 101
      prefix: --paired
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Identifier for predict module
    inputBinding:
      position: 101
      prefix: --predict
  - id: prefix
    type:
      - 'null'
      - boolean
    doc: Prefix for db and log files to be created(Default = kmer). Also you can
      specify folder where you want the db to be created. We recommend that 
      prefix and config point to the same folder for cleanliness but this is not
      required
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reads_file
    type:
      - 'null'
      - boolean
    doc: A separate reads file is created which has all the reads covering all 
      the locus.
    inputBinding:
      position: 101
      prefix: -r
  - id: schemes
    type:
      - 'null'
      - boolean
    doc: Display the list of available schemes
    inputBinding:
      position: 101
      prefix: --schemes
  - id: single
    type:
      - 'null'
      - boolean
    doc: Flag for specifying single end files.
    inputBinding:
      position: 101
      prefix: --single
  - id: species
    type:
      - 'null'
      - string
    doc: Species name from the pubMLST schemes (use "--species show" to get list
      of available schemes) "all" will download and build all
    inputBinding:
      position: 101
      prefix: --species
  - id: time_report
    type:
      - 'null'
      - boolean
    doc: Time for each analysis will also be reported.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Prints the output to a file instead of stdout.
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmlst:0.6.3--py_0
