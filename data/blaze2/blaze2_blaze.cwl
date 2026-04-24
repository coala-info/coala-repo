cwlVersion: v1.2
class: CommandLineTool
baseCommand: blaze
label: blaze2_blaze
doc: "BLAZE2 is a tool for demultiplexing 10X single cell long-read RNA-seq data.
  It takes fastq files as input and output a whitelist of barcodes and a fastq with
  demultiplexed reads.\n\nTool homepage: https://github.com/shimlab/BLAZE"
inputs:
  - id: input_fastq_filename_directory
    type: File
    doc: Filename of input fastq files. Can be a directory or a single file.
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of reads process together as a batch. Note that if the specified
      number larger than the number of reads in each fastq files, all reads in 
      the file will be processed as a batch.
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: count_threshold
    type:
      - 'null'
      - int
    doc: Output the whitelist base of the count threshold of high-quality 
      putative barcodes
    inputBinding:
      position: 102
      prefix: --count-threshold
  - id: expect_cells
    type:
      - 'null'
      - int
    doc: Expected number of cells.
    inputBinding:
      position: 102
      prefix: --expect-cells
  - id: force_cells
    type:
      - 'null'
      - int
    doc: Force the number of cells to be the specified number. This option is 
      useful when the expected number of cells is known.
    inputBinding:
      position: 102
      prefix: --force-cells
  - id: full_bc_whitelist
    type:
      - 'null'
      - File
    doc: Filename of the full barcode whitelist. If not specified, the 
      corresponding version of 10X whitelist will be used.
    inputBinding:
      position: 102
      prefix: --full-bc-whitelist
  - id: high_sensitivity_mode
    type:
      - 'null'
      - boolean
    doc: Turn on the sensitivity mode, which increases the sensitivity of 
      barcode detections but potentially increase the number false/uninformative
      BC in the whitelist. Identification of empty droplets are recommended in 
      downstream
    inputBinding:
      position: 102
      prefix: --high-sensitivity-mode
  - id: kit_version
    type:
      - 'null'
      - string
    doc: Choose from 10X Single Cell 3ʹ gene expression v4, v3, v2 (3v4, 3v3, 
      3v2) or 5ʹ gene expression v3, v2 (5v3, 5v2). If using other protocols, 
      please do not specify this option and specify --full-bc-whitelist and 
      --umi-len instead.
    inputBinding:
      position: 102
      prefix: --10x-kit-version
  - id: known_bc_list
    type:
      - 'null'
      - File
    doc: A file specifies a list of barcodes for demultiplexing. If not 
      specified, the barcodes will be assigned to the whitelist from the 
      whitelisting step.
    inputBinding:
      position: 102
      prefix: --known-bc-list
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: Maximum edit distance allowed between a putative barcode and a barcode 
      for a read to be assigned to the barcode.
    inputBinding:
      position: 102
      prefix: --max-edit-distance
  - id: minimal_stdout
    type:
      - 'null'
      - boolean
    doc: Minimise the command-line printing.
    inputBinding:
      position: 102
      prefix: --minimal_stdout
  - id: minq
    type:
      - 'null'
      - int
    doc: Minimum phred score for all bases in a putative BC to define a "high 
      quality putative barcode".
    inputBinding:
      position: 102
      prefix: --minQ
  - id: no_demultiplexing
    type:
      - 'null'
      - boolean
    doc: Do not perform the demultiplexing step.
    inputBinding:
      position: 102
      prefix: --no-demultiplexing
  - id: no_restrand
    type:
      - 'null'
      - boolean
    doc: 'By default, blaze2 re-strands all reads to transcript strand: reads from
      the reverse strand (those with polyT instead of polyA) will be reverse complemented
      the their quality scores will be reversed. This option will disable the re-stranding.'
    inputBinding:
      position: 102
      prefix: --no-restrand
  - id: no_whitelisting
    type:
      - 'null'
      - boolean
    doc: Do not perform whitelisting, if dumultiplexing is enabled, the reads 
      will be assigned to know list of barcodes specified by --known-bc-list.
    inputBinding:
      position: 102
      prefix: --no-whitelisting
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Filename of output files. Note that the output can be directed to a 
      different directory by specifying the path in the prefix. E.g., 
      --output-prefix /path/to/output/prefix
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: By default, BLAZE will skip the steps generating the existing file(s). 
      Specify this option to rerun the steps those steps and overwrite the 
      existing output files.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to used.
    inputBinding:
      position: 102
      prefix: --threads
  - id: umi_len
    type:
      - 'null'
      - int
    doc: UMI length, will only be used when --kit-version is not specified.
    inputBinding:
      position: 102
      prefix: --umi-len
outputs:
  - id: output_fastq
    type:
      - 'null'
      - File
    doc: Filename of output fastq file name. Note that the filename has to end 
      with .fastq, .fq, .fastq.gz or .fq.gz.
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blaze2:2.5.1--pyhdfd78af_0
