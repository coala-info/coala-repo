cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-map
label: tepid_tepid-map
doc: "Map paired-end data using bowtie2 and yaha (TEPID mapping step). Writes
  [name].bam, [name].bam.bai, [name].split.bam and [name].umap.fastq.\n\nTool
  homepage: https://github.com/ListerLab/TEPID"
inputs:
  - id: bowtie2_index_files
    type:
      type: array
      items: File
    doc: bowtie2 index files (.1.bt2, .2.bt2, .3.bt2, .4.bt2, .rev.1.bt2,
      .rev.2.bt2), staged in the working directory
  - id: bowtie2_index
    type: string
    doc: path to bowtie2 index (index prefix, e.g. genome)
    inputBinding:
      position: 101
      prefix: -x
  - id: yaha_index_files
    type:
      type: array
      items: File
    doc: yaha index files (.X15_01_65525S index and .nib2 genome), staged in the
      working directory
  - id: yaha_index
    type: string
    doc: path to yaha index (e.g. genome.X15_01_65525S)
    inputBinding:
      position: 101
      prefix: -y
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores to use
    inputBinding:
      position: 101
      prefix: -p
  - id: insert_size
    type: int
    doc: average insert size
    inputBinding:
      position: 101
      prefix: -s
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: -n
  - id: fastq1
    type: File
    doc: fastq file with #1 mates
    inputBinding:
      position: 101
      prefix: '-1'
  - id: fastq2
    type: File
    doc: fastq file with #2 mates
    inputBinding:
      position: 101
      prefix: '-2'
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recursive (optional)
    inputBinding:
      position: 101
      prefix: -r
  - id: gzip_fastq
    type:
      - 'null'
      - boolean
    doc: gzip fastq files (optional)
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: bam
    type: File
    doc: sorted bowtie2 alignment
    secondaryFiles:
      - .bai
    outputBinding:
      glob: $(inputs.sample_name).bam
  - id: split_bam
    type: File
    doc: split reads alignment from yaha
    outputBinding:
      glob: $(inputs.sample_name).split.bam
  - id: unmapped_fastq
    type:
      - 'null'
      - File
    doc: unmapped reads (compressed when -z is used)
    outputBinding:
      glob: $(inputs.sample_name).umap.fastq*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.bowtie2_index_files.concat(inputs.yaha_index_files))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
