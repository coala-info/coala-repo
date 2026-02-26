cwlVersion: v1.2
class: CommandLineTool
baseCommand: snaptools align-paired-end
label: snaptools_align-paired-end
doc: "Align paired-end FASTQ files to a reference genome.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: aligner to use. Currently, snaptools supports bwa, bowtie, bowtie2 and 
      minimap2.
    default: bwa
    inputBinding:
      position: 101
      prefix: --aligner
  - id: aligner_options
    type:
      - 'null'
      - type: array
        items: string
    doc: list of strings indicating options you would like passed to 
      alignerstrongly do not recommand to change unless you know what you are 
      doing. the default is to align reads without filteration.
    default: None
    inputBinding:
      position: 101
      prefix: --aligner-options
  - id: if_sort
    type:
      - 'null'
      - boolean
    doc: weather to sort the bam file based on the read name
    default: 'True'
    inputBinding:
      position: 101
      prefix: --if-sort
  - id: input_fastq1
    type: File
    doc: fastq file contains R1 reads, currently supports fastq, gz, bz2 file
    inputBinding:
      position: 101
      prefix: --input-fastq1
  - id: input_fastq2
    type: File
    doc: fastq file contains R2 reads, currently supports fastq, gz, bz2 file
    inputBinding:
      position: 101
      prefix: --input-fastq2
  - id: input_reference
    type: File
    doc: reference genome file contains the reference genome that reads are 
      mapped against, the genome index must be under the same folder
    inputBinding:
      position: 101
      prefix: --input-reference
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'min number of fragments per barcode. barcodes of total fragments less than
      --min-cov will be filreted before alingment. Note: though this feature is included,
      we found it barely benefit anything, recommand to set it 0.'
    default: 0
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of alignment threads, also number of threads for sorting a bam 
      file.
    default: 1
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: whether to overwrite the output file if it already exists
    default: false
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: path_to_aligner
    type:
      - 'null'
      - Directory
    doc: path to fold that contains bwa
    default: None
    inputBinding:
      position: 101
      prefix: --path-to-aligner
  - id: read_fastq_command
    type:
      - 'null'
      - string
    doc: command line to execute for each of the input file. This command should
      generate FASTQ text and send it to stdout. For example, 
      --read-fastq-command should be zcat, bzcat and cat for .gz, .bz2 and plain
      fastq file respectively
    default: None
    inputBinding:
      position: 101
      prefix: --read-fastq-command
  - id: tmp_folder
    type:
      - 'null'
      - Directory
    doc: directory to store temporary files. If not given, snaptools will 
      automaticallygenerate a temporary location to store temporary files
    default: None
    inputBinding:
      position: 101
      prefix: --tmp-folder
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates output the progress.
    default: true
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_bam
    type: File
    doc: output bam file contains unfiltered alignments
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
