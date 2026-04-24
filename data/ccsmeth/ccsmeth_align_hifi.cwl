cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth_align_hifi
label: ccsmeth_align_hifi
doc: "align hifi reads using pbmm2/minimap2/bwa, default pbmm2\n\nTool homepage: https://github.com/PengNi/ccsmeth"
inputs:
  - id: bestn
    type:
      - 'null'
      - int
    doc: retain at most n alignments in minimap2. default 3, which means 2 
      secondary alignments are retained. Do not use 2, cause -N1 is not 
      suggested for high accuracy of alignment. [This arg is for further 
      extension.]
    inputBinding:
      position: 101
      prefix: --bestn
  - id: header
    type:
      - 'null'
      - boolean
    doc: save header annotations from bam/sam. DEPRECATED
    inputBinding:
      position: 101
      prefix: --header
  - id: hifireads
    type: File
    doc: path to hifireads.bam/sam/fastq_with_pulseinfo file as input
    inputBinding:
      position: 101
      prefix: --hifireads
  - id: path_to_bwa
    type:
      - 'null'
      - File
    doc: full path to the executable binary bwa file. If not specified, it is 
      assumed that bwa is in the PATH.
    inputBinding:
      position: 101
      prefix: --path_to_bwa
  - id: path_to_minimap2
    type:
      - 'null'
      - File
    doc: full path to the executable binary minimap2 file. If not specified, it 
      is assumed that minimap2 is in the PATH.
    inputBinding:
      position: 101
      prefix: --path_to_minimap2
  - id: path_to_pbmm2
    type:
      - 'null'
      - File
    doc: full path to the executable binary pbmm2 file. If not specified, it is 
      assumed that pbmm2 is in the PATH.
    inputBinding:
      position: 101
      prefix: --path_to_pbmm2
  - id: path_to_samtools
    type:
      - 'null'
      - File
    doc: full path to the executable binary samtools file. If not specified, it 
      is assumed that samtools is in the PATH.
    inputBinding:
      position: 101
      prefix: --path_to_samtools
  - id: ref
    type: File
    doc: path to genome reference to be aligned, in fasta/fa format. If using 
      bwa, the reference must have already been indexed.
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads, default 5
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_bwa
    type:
      - 'null'
      - boolean
    doc: use bwa instead of pbmm2 for alignment
    inputBinding:
      position: 101
      prefix: --bwa
  - id: use_minimap2
    type:
      - 'null'
      - boolean
    doc: use minimap2 instead of pbmm2 for alignment
    inputBinding:
      position: 101
      prefix: --minimap2
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file path for alignment results, bam/sam supported. If not 
      specified, the results will be saved in input_file_prefix.bam by default.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
