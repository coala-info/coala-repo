cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - demult
label: seismic-rna_seismic_demult
doc: 'Split multiplexed FASTQ files by their barcodes.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: fasta
    type: File
    doc: FASTA file of reference sequences
    inputBinding:
      position: 200
  - id: fastqx
    type:
      - type: array
        items: File
        inputBinding:
          prefix: --fastqx
    doc: FASTQ files of paired-end reads with mates 1 and 2 in separate files (the
      option is given once per file)
    inputBinding:
      position: 100
  - id: phred_enc
    type:
      - 'null'
      - int
    doc: 'Specify the Phred score encoding of FASTQ and SAM/BAM/CRAM files [default:
      33]'
    inputBinding:
      position: 100
      prefix: --phred-enc
  - id: barcode_start
    type:
      - 'null'
      - int
    doc: 'Index of start of barcode [default: 0]'
    inputBinding:
      position: 100
      prefix: --barcode-start
  - id: barcode_end
    type:
      - 'null'
      - int
    doc: 'Length of barcode [default: 0]'
    inputBinding:
      position: 100
      prefix: --barcode-end
  - id: out_dir
    type: string
    default: out
    doc: 'Write all output files to this directory [default: ./out]'
    inputBinding:
      position: 100
      prefix: --out-dir
  - id: parallel_demultiplexing
    type:
      - 'null'
      - string
    doc: ' Whether to run demultiplexing at maximum speed by submitting multithreaded
      grep functions [default: False]'
    inputBinding:
      position: 100
      prefix: --parallel-demultiplexing
  - id: clipped
    type:
      - 'null'
      - int
    doc: 'Designates the amount of clipped patterns to search for in the sample, will
      raise compution time [default: 0]'
    inputBinding:
      position: 100
      prefix: --clipped
  - id: mismatch_tolerence
    type:
      - 'null'
      - int
    doc: 'Designates the allowable amount of mismatches allowed in a string and still
      be considered a valid pattern find. will increase non-parallel computation at
      a factorial rate. use caution going above 2 mismatches. does not apply to clipped
      sequences. [default: 0]'
    inputBinding:
      position: 100
      prefix: --mismatch-tolerence
  - id: index_tolerance
    type:
      - 'null'
      - int
    doc: 'Designates the allowable amount of distance you allow the pattern to be
      found in a read from the reference index [default: 0]'
    inputBinding:
      position: 100
      prefix: --index-tolerance
  - id: demulti_overwrite
    type:
      - 'null'
      - string
    doc: 'Desiginates whether to overwrite the grepped fastq. should only be used
      if changing setting on the same sample [default: False]'
    inputBinding:
      position: 100
      prefix: --demulti-overwrite
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --keep-tmp
  - id: erase_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --erase-tmp
  - id: refs_meta
    type:
      - 'null'
      - File
    doc: Add reference metadata from this CSV file to exported results
    inputBinding:
      position: 100
      prefix: --refs-meta
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
