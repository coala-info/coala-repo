cwlVersion: v1.2
class: CommandLineTool
baseCommand: hint pre
label: hint_pre
doc: "Preprocessing Hi-C data, alignment, create contact matrices, and normalization.\n\
  \nTool homepage: https://github.com/suwangbio/HiNT_py3"
inputs:
  - id: alignerbwa
    type:
      - 'null'
      - File
    doc: Path to your BWA aligner, required when your input file(s) is in fastq 
      format, ignore when you input a bam file.
    inputBinding:
      position: 101
      prefix: --alignerbwa
  - id: bwa_index
    type:
      - 'null'
      - File
    doc: Path to BWA Index if your input file is fastq format, ignore if your 
      input is bam file.
    inputBinding:
      position: 101
      prefix: --bwaIndex
  - id: coolerpath
    type:
      - 'null'
      - File
    doc: Path to cooler tool, required when the format is cool via cooler
    inputBinding:
      position: 101
      prefix: --coolerpath
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Specify your species, choose from hg38, hg19, and mm10. DEFAULT: hg19'
    default: hg19
    inputBinding:
      position: 101
      prefix: --genome
  - id: hicdata
    type: string
    doc: Hi-C raw data with fastq format, two mates seperate with a comma ',', 
      or bam file after alignment.
    inputBinding:
      position: 101
      prefix: --data
  - id: informat
    type:
      - 'null'
      - string
    doc: "Format for the Hi-C input data, choose from 'fastq' and 'bam', DEFAULT:
      fastq"
    default: fastq
    inputBinding:
      position: 101
      prefix: --informat
  - id: juicerpath
    type:
      - 'null'
      - File
    doc: Path to juicer tools, required when the format is hic via juicer tools
    inputBinding:
      position: 101
      prefix: --juicerpath
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix for the result files. If not set, 'NA' will be used instead
    default: NA
    inputBinding:
      position: 101
      prefix: --name
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory, where you want to store all the output 
      files, if not set, the current directory will be used
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outformat
    type:
      - 'null'
      - string
    doc: "Format for the output contact matrix, choose from 'cooler' and 'juicer',
      DEFAULT: cooler"
    default: cooler
    inputBinding:
      position: 101
      prefix: --outformat
  - id: pairtoolspath
    type: File
    doc: Path to pairtools
    inputBinding:
      position: 101
      prefix: --pairtoolspath
  - id: referencedir
    type: Directory
    doc: the reference directory that downloaded from dropbox dropbox. 
      (https://www.dropbox.com/sh/2ufsyu4wvrboxxp/AABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.)
    inputBinding:
      position: 101
      prefix: --refdir
  - id: resolution
    type:
      - 'null'
      - string
    doc: Generate Hi-C contact matrix in user specified resolution. If not set, 
      HiNT will only output Hi-C contact matrix in 50kb, 100kb, and 1Mb
    inputBinding:
      position: 101
      prefix: --resolution
  - id: samtoolspath
    type: File
    doc: Path to samtools, e.g./n/app/samtools/1.3.1/bin/samtools
    inputBinding:
      position: 101
      prefix: --samtoolspath
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for running BWA, DEFAULT: 16'
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hint:2.2.8--py_1
stdout: hint_pre.out
