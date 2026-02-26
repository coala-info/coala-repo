cwlVersion: v1.2
class: CommandLineTool
baseCommand: schicexplorer_scHicDemultiplex
label: schicexplorer_scHicDemultiplex
doc: "scHicDemultiplex demultiplexes fastq files from Nagano 2017: \"Cell-cycle dynamics
  of chromosomal organization at single-cell resolution\" according their barcodes
  to a seperated forward and reverse strand fastq files per cell.\n\nTool homepage:
  https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: barcode_file
    type: File
    doc: The fastq files to demultiplex
    inputBinding:
      position: 101
      prefix: --barcodeFile
  - id: buffer_size
    type:
      - 'null'
      - float
    doc: Number of lines to buffer in memory, if full, write the data to disk.
    default: 20000000.0
    inputBinding:
      position: 101
      prefix: --bufferSize
  - id: fastq
    type:
      type: array
      items: File
    doc: "The fastq files to demultiplex of Nagano 2017 Cell cycle dynamics of chromosomal
      organization at single- cell resolutionGEO: GSE94489. Files need to have four
      FASTQ lines per read:/1 forward; /2 barcode forward; /3 bardcode reverse; /4
      reverse read.Please be aware the files can be downloaded via the command fastq-dump
      to be in the right format:fastq-dump --accession SRR5229025 --split-files --defline-seq
      '@$sn[_$rn]/$ri' --defline-qual '+' --split-spot --stdout SRR5229025 > SRR5229025.fastq"
    inputBinding:
      position: 101
      prefix: --fastq
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Path of folder to save the demultiplexed files
    default: demultiplexed
    inputBinding:
      position: 101
      prefix: --outputFolder
  - id: srr_to_sample_file
    type: string
    doc: The mappings from SRR number to sample id as given in the barcode file.
    inputBinding:
      position: 101
      prefix: --srrToSampleFile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
stdout: schicexplorer_scHicDemultiplex.out
