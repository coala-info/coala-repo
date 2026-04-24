cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava ratio
label: phava_ratio
doc: "Run the pipeline with short reads instead of long reads\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: directory
    type: Directory
    doc: Directory where data and output are stored *** USE THE SAME WORK 
      DIRECTORY FOR ALL PHAVA OPERATIONS ***
    inputBinding:
      position: 101
      prefix: --dir
  - id: fastq
    type:
      - 'null'
      - File
    doc: Name of the reads file to be used for mapping
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Name of the file with reverse reads to be used for mapping (only for 
      paired short reads!)
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: inv
    type:
      - 'null'
      - File
    doc: Fasta file of forward and inverted repeats (ie. generated from create 
      command)
    inputBinding:
      position: 101
      prefix: --inv
  - id: keep_sam
    type:
      - 'null'
      - boolean
    doc: Keep the sam file from the mapping
    inputBinding:
      position: 101
      prefix: --keepSam
  - id: log
    type:
      - 'null'
      - boolean
    doc: Should the logging info be output to stdout? Otherwise, it will be 
      written to 'PhaVa.log'
    inputBinding:
      position: 101
      prefix: --log
  - id: max_mismatch
    type:
      - 'null'
      - float
    doc: Maximum proportion of inverton sequence that can be mismatch before a 
      read is removed
    inputBinding:
      position: 101
      prefix: --maxMismatch
  - id: min_rc
    type:
      - 'null'
      - int
    doc: The minimum count of mapped reads to an 'inverted' inverton for it to 
      be reported in the output
    inputBinding:
      position: 101
      prefix: --minRC
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: Report mapping results for all putative invertons, regardless of 
      outcome
    inputBinding:
      position: 101
      prefix: --reportAll
  - id: short_reads
    type:
      - 'null'
      - boolean
    doc: Run the pipeline with short reads instead of long reads
    inputBinding:
      position: 101
      prefix: --short-reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_ratio.out
