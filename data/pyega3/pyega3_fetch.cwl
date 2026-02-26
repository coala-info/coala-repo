cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyega3 fetch
label: pyega3_fetch
doc: "Fetch data from EGA.\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs:
  - id: identifier
    type: string
    doc: Id for dataset (e.g. EGAD00000000001) or file (e.g. EGAF12345678901)
    inputBinding:
      position: 1
  - id: delete_temp_files
    type:
      - 'null'
      - boolean
    doc: Do not keep those temporary, partial files which were left on the disk 
      after a failed transfer.
    inputBinding:
      position: 102
      prefix: --delete-temp-files
  - id: end
    type:
      - 'null'
      - int
    doc: The end position of the range on the reference, 0-based exclusive. If 
      specified, reference-name or reference-md5 must also be specified.
    inputBinding:
      position: 102
      prefix: --end
  - id: format
    type:
      - 'null'
      - string
    doc: The format of data to request.
    inputBinding:
      position: 102
      prefix: --format
  - id: max_retries
    type:
      - 'null'
      - int
    doc: The maximum number of times to retry a failed transfer. Any negative 
      number means infinite number of retries.
    inputBinding:
      position: 102
      prefix: --max-retries
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory. The files will be saved into this directory. Must exist.
      Default: the current working directory.'
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: reference_md5
    type:
      - 'null'
      - string
    doc: The MD5 checksum uniquely representing the requested reference sequence
      as a lower-case hexadecimal string, calculated as the MD5 of the 
      upper-case sequence excluding all whitespace characters.
    inputBinding:
      position: 102
      prefix: --reference-md5
  - id: reference_name
    type:
      - 'null'
      - string
    doc: The reference sequence name, for example 'chr1', '1', or 'chrX'. If 
      unspecified, all data is returned.
    inputBinding:
      position: 102
      prefix: --reference-name
  - id: retry_wait
    type:
      - 'null'
      - int
    doc: The number of seconds to wait before retrying a failed transfer.
    inputBinding:
      position: 102
      prefix: --retry-wait
  - id: start
    type:
      - 'null'
      - int
    doc: The start position of the range on the reference, 0-based, inclusive. 
      If specified, reference-name or reference-md5 must also be specified.
    inputBinding:
      position: 102
      prefix: --start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
stdout: pyega3_fetch.out
