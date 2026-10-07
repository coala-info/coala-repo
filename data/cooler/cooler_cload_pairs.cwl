cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - cload
  - pairs
label: cooler_cload_pairs
doc: "Bin any text file or stream of pairs.\n\nPairs data need not be sorted. Accepts
  compressed files.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: bins
    type: File
    doc: 'One of the following: <TEXT:INTEGER> : 1. Path to a chromsizes file, 2.
      Bin size in bp, or <TEXT> : Path to BED file defining the genomic bin segmentation.
      Give a chromsizes file together with bin_size, or a BED file alone.'
    inputBinding:
      position: 1
      valueFrom: "$(inputs.bin_size ? self.path + ':' + inputs.bin_size : self.path)"
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size in bp, used when bins is a chromsizes file.
  - id: pairs_path
    type: File
    doc: Path to contacts (i.e. read pairs) file.
    inputBinding:
      position: 2
  - id: cool_path
    type: string
    doc: Output COOL file path or URI.
    inputBinding:
      position: 3
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to JSON file containing user metadata.
    inputBinding:
      position: 104
      prefix: --metadata
  - id: assembly
    type:
      - 'null'
      - string
    doc: Name of genome assembly (e.g. hg19, mm10)
    inputBinding:
      position: 104
      prefix: --assembly
  - id: chrom1
    type: int
    doc: chrom1 field number (one-based)
    inputBinding:
      position: 104
      prefix: --chrom1
  - id: pos1
    type: int
    doc: pos1 field number (one-based)
    inputBinding:
      position: 104
      prefix: --pos1
  - id: chrom2
    type: int
    doc: chrom2 field number (one-based)
    inputBinding:
      position: 104
      prefix: --chrom2
  - id: pos2
    type: int
    doc: pos2 field number (one-based)
    inputBinding:
      position: 104
      prefix: --pos2
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Positions are zero-based
    inputBinding:
      position: 104
      prefix: --zero-based
  - id: comment_char
    type:
      - 'null'
      - string
    doc: Comment character that indicates lines to ignore.
    inputBinding:
      position: 104
      prefix: --comment-char
  - id: no_symmetric_upper
    type:
      - 'null'
      - boolean
    doc: Create a complete square matrix without implicit symmetry. This allows
      for distinct upper- and lower-triangle values
    inputBinding:
      position: 104
      prefix: --no-symmetric-upper
  - id: input_copy_status
    type:
      - 'null'
      - string
    doc: 'Copy status of input data when using symmetric-upper storage: unique or
      duplex.'
    inputBinding:
      position: 104
      prefix: --input-copy-status
  - id: field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --field
    doc: Specify quantitative input fields to aggregate into value columns using
      the syntax <field-name>=<field-number>. Optionally, append ':' followed by
      dtype=<dtype> and/or agg=<agg>. Field numbers are 1-based. Repeat for each
      additional field.
    inputBinding:
      position: 104
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Size in number of lines/records of data chunks to read and process
      from the input stream at a time.
    inputBinding:
      position: 104
      prefix: --chunksize
  - id: mergebuf
    type:
      - 'null'
      - int
    doc: Total number of pixel records to buffer per epoch of merging data.
      Defaults to the same value as `chunksize`.
    inputBinding:
      position: 104
      prefix: --mergebuf
  - id: max_merge
    type:
      - 'null'
      - int
    doc: Maximum number of chunks to merge in a single pass.
    inputBinding:
      position: 104
      prefix: --max-merge
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: Create temporary files in a specified directory. Pass - to use the
      platform default temp dir.
    inputBinding:
      position: 104
      prefix: --temp-dir
  - id: no_delete_temp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary files when finished.
    inputBinding:
      position: 104
      prefix: --no-delete-temp
  - id: storage_options
    type:
      - 'null'
      - string
    doc: Options to modify the data filter pipeline, as a comma-separated list
      of key-value pairs 'k1=v1,k2=v2,...'.
    inputBinding:
      position: 104
      prefix: --storage-options
  - id: append
    type:
      - 'null'
      - boolean
    doc: Pass this flag to append the output cooler to an existing file instead
      of overwriting the file.
    inputBinding:
      position: 104
      prefix: --append
outputs:
  - id: cool
    type: File
    doc: Output COOL file
    outputBinding:
      glob: $(inputs.cool_path.split('::')[0])
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
