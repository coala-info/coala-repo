cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler load
label: cooler_load
doc: "Create a cooler from a pre-binned matrix.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: bins_path
    type: string
    doc: 'One of the following: <TEXT:INTEGER> : 1. Path to a chromsizes file, 2.
      Bin size in bp, or <TEXT> : Path to BED file defining the genomic bin segmentation.'
    inputBinding:
      position: 1
  - id: pixels_path
    type: File
    doc: Text file containing nonzero pixel values. May be gzipped. Pass '-' to 
      use stdin.
    inputBinding:
      position: 2
  - id: cool_path
    type: File
    doc: Output COOL file path or URI.
    inputBinding:
      position: 3
  - id: append
    type:
      - 'null'
      - boolean
    doc: Pass this flag to append the output cooler to an existing file instead 
      of overwriting the file.
    inputBinding:
      position: 104
      prefix: --append
  - id: assembly
    type:
      - 'null'
      - string
    doc: Name of genome assembly (e.g. hg19, mm10)
    inputBinding:
      position: 104
      prefix: --assembly
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Size in number of lines/records of data chunks to read and process from
      the input stream at a time. These chunks will be saved as temporary 
      partial coolers and then merged.
    inputBinding:
      position: 104
      prefix: --chunksize
  - id: comment_char
    type:
      - 'null'
      - string
    doc: Comment character that indicates lines to ignore.
    inputBinding:
      position: 104
      prefix: --comment-char
  - id: count_as_float
    type:
      - 'null'
      - boolean
    doc: Store the 'count' column as floating point values instead of as 
      integers. Can also be specified using the `--field` option.
    inputBinding:
      position: 104
      prefix: --count-as-float
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: Add supplemental value fields or override default field numbers for the
      specified format. Specify quantitative input fields to aggregate into 
      value columns using the syntax ``--field <field-name>=<field-number>``. 
      Optionally, append ``:`` followed by ``dtype=<dtype>`` to specify the data
      type (e.g. float). Field numbers are 1-based. Repeat the ``--field`` 
      option for each additional field.
    inputBinding:
      position: 104
      prefix: --field
  - id: format
    type: string
    doc: "'coo' refers to a tab-delimited sparse triplet file (bin1, bin2, count).
      'bg2' refers to a 2D bedGraph-like file (chrom1, start1, end1, chrom2, start2,
      end2, count)."
    inputBinding:
      position: 104
      prefix: --format
  - id: input_copy_status
    type:
      - 'null'
      - string
    doc: 'Copy status of input data when using symmetric-upper storage. | `unique`:
      Incoming data comes from a unique half of a symmetric matrix, regardless of
      how element coordinates are ordered. Execution will be aborted if duplicates
      are detected. `duplex`: Incoming data contains upper- and lower-triangle duplicates.
      All lower-triangle input elements will be discarded! | If you wish to treat
      lower- and upper-triangle input data as distinct, use the ``--no-symmetric-upper``
      option instead.'
    inputBinding:
      position: 104
      prefix: --input-copy-status
  - id: max_merge
    type:
      - 'null'
      - int
    doc: Maximum number of chunks to merge in a single pass.
    inputBinding:
      position: 104
      prefix: --max-merge
  - id: mergebuf
    type:
      - 'null'
      - int
    doc: Total number of records to buffer per epoch of merging data. Defaults 
      to the same value as `chunksize`.
    inputBinding:
      position: 104
      prefix: --mergebuf
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to JSON file containing user metadata.
    inputBinding:
      position: 104
      prefix: --metadata
  - id: no_delete_temp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary files when finished.
    inputBinding:
      position: 104
      prefix: --no-delete-temp
  - id: no_symmetric_upper
    type:
      - 'null'
      - boolean
    doc: Create a complete square matrix without implicit symmetry. This allows 
      for distinct upper- and lower-triangle values
    inputBinding:
      position: 104
      prefix: --no-symmetric-upper
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: Pass this flag if the bin IDs listed in a COO file are one-based 
      instead of zero-based.
    inputBinding:
      position: 104
      prefix: --one-based
  - id: storage_options
    type:
      - 'null'
      - string
    doc: Options to modify the data filter pipeline. Provide as a 
      comma-separated list of key-value pairs of the form 'k1=v1,k2=v2,...'. See
      http://docs.h5py.org/en/stable/high/data set.html#filter-pipeline for more
      details.
    inputBinding:
      position: 104
      prefix: --storage-options
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Create temporary files in a specified directory. Pass ``-`` to use the 
      platform default temp dir.
    inputBinding:
      position: 104
      prefix: --temp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_load.out
