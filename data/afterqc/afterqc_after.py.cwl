cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - after.py
label: afterqc_after.py
doc: "Automatic Filtering, Trimming, Error Removing and Quality Control for Illumina
  fastq data\n\nTool homepage: https://github.com/OpenGene/AfterQC"
inputs:
  - id: allow_mismatch_in_poly
    type:
      - 'null'
      - int
    doc: the count of allowed mismatches when detection polyX. Default 2 means 
      allow 2 mismatches for polyX detection
    default: 2
    inputBinding:
      position: 101
      prefix: --allow_mismatch_in_poly
  - id: barcode
    type:
      - 'null'
      - string
    doc: specify whether deal with barcode sequencing files, default is on, 
      which means all files with barcode_flag in filename will be treated as 
      barcode sequencing files
    default: on
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_flag
    type:
      - 'null'
      - string
    doc: specify the name flag of a barcoded file, default is barcode, which 
      means a file with name *barcode* is a barcoded file
    default: barcode
    inputBinding:
      position: 101
      prefix: --barcode_flag
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: specify the designed length of barcode
    inputBinding:
      position: 101
      prefix: --barcode_length
  - id: barcode_verify
    type:
      - 'null'
      - string
    doc: specify the verify sequence of a barcode which is adjunct to the 
      barcode
    inputBinding:
      position: 101
      prefix: --barcode_verify
  - id: compression
    type:
      - 'null'
      - int
    doc: set compression level (0~9) for gzip output, default is 2 (0 = best 
      speed, 9 = best compression).
    default: 2
    inputBinding:
      position: 101
      prefix: --compression
  - id: debubble
    type:
      - 'null'
      - boolean
    doc: specify whether apply debubble algorithm to remove the reads in the 
      bubbles. Default is False
    default: false
    inputBinding:
      position: 101
      prefix: --debubble
  - id: draw
    type:
      - 'null'
      - string
    doc: specify whether draw the pictures or not, when use debubble or QC. 
      Default is on
    default: on
    inputBinding:
      position: 101
      prefix: --draw
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: force gzip compression for output, even the input is not gzip 
      compressed
    inputBinding:
      position: 101
      prefix: --gzip
  - id: index1_file
    type:
      - 'null'
      - File
    doc: file name of 7' index. If input_dir is specified, then this arg is 
      ignored.
    inputBinding:
      position: 101
      prefix: --index1_file
  - id: index1_flag
    type:
      - 'null'
      - string
    doc: specify the name flag of index1, default is I1, which means a file with
      name *I1* is index2 file
    default: I1
    inputBinding:
      position: 101
      prefix: --index1_flag
  - id: index2_file
    type:
      - 'null'
      - File
    doc: file name of 5' index. If input_dir is specified, then this arg is 
      ignored.
    inputBinding:
      position: 101
      prefix: --index2_file
  - id: index2_flag
    type:
      - 'null'
      - string
    doc: specify the name flag of index2, default is I2, which means a file with
      name *I2* is index2 file
    default: I2
    inputBinding:
      position: 101
      prefix: --index2_flag
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: the input dir to process automatically. If read1_file are input_dir are
      not specified, then current dir (.) is specified to input_dir
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: mask_mismatch
    type:
      - 'null'
      - boolean
    doc: set the qual num to 0 for mismatched base pairs in overlapped areas to 
      mask them out
    inputBinding:
      position: 101
      prefix: --mask_mismatch
  - id: n_base_limit
    type:
      - 'null'
      - int
    doc: if exists more than maxn bases have N, then this read/pair is bad. 
      Default is 5
    default: 5
    inputBinding:
      position: 101
      prefix: --n_base_limit
  - id: no_correction
    type:
      - 'null'
      - boolean
    doc: disable base correction for mismatched base pairs in overlapped areas
    inputBinding:
      position: 101
      prefix: --no_correction
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: disable overlap analysis (usually much faster with this option)
    inputBinding:
      position: 101
      prefix: --no_overlap
  - id: poly_size_limit
    type:
      - 'null'
      - int
    doc: if exists one polyX(polyG means GGGGGGGGG...), and its length is >= 
      poly_size_limit, then this read/pair is bad. Default is 35
    default: 35
    inputBinding:
      position: 101
      prefix: --poly_size_limit
  - id: qc_kmer
    type:
      - 'null'
      - int
    doc: specify the kmer length for KMER statistics for QC, default is 8
    default: 8
    inputBinding:
      position: 101
      prefix: --qc_kmer
  - id: qc_only
    type:
      - 'null'
      - boolean
    doc: if qconly is true, only QC result will be output, this can be much fast
    inputBinding:
      position: 101
      prefix: --qc_only
  - id: qc_sample
    type:
      - 'null'
      - int
    doc: sample up to qc_sample reads when do QC, 0 means sample all reads. 
      Default is 200,000
    default: 200000
    inputBinding:
      position: 101
      prefix: --qc_sample
  - id: qualified_quality_phred
    type:
      - 'null'
      - int
    doc: the quality value that a base is qualifyed. Default 15 means phred base
      quality >=Q15 is qualified.
    default: 15
    inputBinding:
      position: 101
      prefix: --qualified_quality_phred
  - id: read1_file
    type:
      - 'null'
      - File
    doc: file name of read1, required. If input_dir is specified, then this arg 
      is ignored.
    inputBinding:
      position: 101
      prefix: --read1_file
  - id: read1_flag
    type:
      - 'null'
      - string
    doc: specify the name flag of read1, default is R1, which means a file with 
      name *R1* is read1 file
    default: R1
    inputBinding:
      position: 101
      prefix: --read1_flag
  - id: read2_file
    type:
      - 'null'
      - File
    doc: file name of read2, if paired. If input_dir is specified, then this arg
      is ignored.
    inputBinding:
      position: 101
      prefix: --read2_file
  - id: read2_flag
    type:
      - 'null'
      - string
    doc: specify the name flag of read2, default is R2, which means a file with 
      name *R2* is read2 file
    default: R2
    inputBinding:
      position: 101
      prefix: --read2_flag
  - id: seq_len_req
    type:
      - 'null'
      - int
    doc: if the trimmed read is shorter than seq_len_req, then this read/pair is
      bad. Default is 35
    default: 35
    inputBinding:
      position: 101
      prefix: --seq_len_req
  - id: store_overlap
    type:
      - 'null'
      - boolean
    doc: specify whether store only overlapped bases of the good reads
    inputBinding:
      position: 101
      prefix: --store_overlap
  - id: trim_front
    type:
      - 'null'
      - int
    doc: number of bases to be trimmed in the head of read. -1 means auto detect
    default: -1
    inputBinding:
      position: 101
      prefix: --trim_front
  - id: trim_pair_same
    type:
      - 'null'
      - string
    doc: use same trimming configuration for read1 and read2 to keep their 
      sequence length identical, default is true
    default: 'true'
    inputBinding:
      position: 101
      prefix: --trim_pair_same
  - id: trim_tail
    type:
      - 'null'
      - int
    doc: number of bases to be trimmed in the tail of read. -1 means auto detect
    default: -1
    inputBinding:
      position: 101
      prefix: --trim_tail
  - id: unqualified_base_limit
    type:
      - 'null'
      - int
    doc: if exists more than unqualified_base_limit bases that quality is lower 
      than qualified quality, then this read/pair is bad. Default is 60
    default: 60
    inputBinding:
      position: 101
      prefix: --unqualified_base_limit
outputs:
  - id: good_output_folder
    type:
      - 'null'
      - Directory
    doc: the folder to store good reads, by default it is named 'good', in the 
      current directory
    outputBinding:
      glob: $(inputs.good_output_folder)
  - id: bad_output_folder
    type:
      - 'null'
      - Directory
    doc: the folder to store bad reads, by default it is named 'bad', in the 
      same folder as good_output_folder
    outputBinding:
      glob: $(inputs.bad_output_folder)
  - id: report_output_folder
    type:
      - 'null'
      - Directory
    doc: the folder to store QC reports, by default it is named 'QC', in the 
      same folder as good_output_folder
    outputBinding:
      glob: $(inputs.report_output_folder)
  - id: debubble_dir
    type:
      - 'null'
      - Directory
    doc: specify the folder to store output of debubble algorithm, default is 
      debubble
    outputBinding:
      glob: $(inputs.debubble_dir)
  - id: overlap_output_folder
    type:
      - 'null'
      - Directory
    doc: the folder to store only overlapped bases of the good reads
    outputBinding:
      glob: $(inputs.overlap_output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afterqc:0.9.7--py27_0
