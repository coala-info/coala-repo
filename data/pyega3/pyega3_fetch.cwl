cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyega3
arguments:
  - position: 10
    valueFrom: fetch
label: pyega3_fetch
doc: "Fetch a dataset or file.\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Extra debugging messages."
    inputBinding:
      position: 1
      prefix: --debug
  - id: config_file
    type:
      - 'null'
      - File
    doc: "JSON file containing credentials/config, e.g. {\"username\":\"user1\",\"password\":\"toor\"}."
    inputBinding:
      position: 2
      prefix: --config-file
  - id: server_file
    type:
      - 'null'
      - File
    doc: "JSON file containing server config (url_auth, url_api, url_api_ticket, client_secret)."
    inputBinding:
      position: 3
      prefix: --server-file
  - id: connections
    type:
      - 'null'
      - int
    doc: "Download using specified number of connections (default: 1 connection)."
    inputBinding:
      position: 4
      prefix: --connections
  - id: test
    type:
      - 'null'
      - boolean
    doc: "Test user activated."
    inputBinding:
      position: 5
      prefix: --test
  - id: max_slice_size
    type:
      - 'null'
      - int
    doc: "Set maximum size for each slice in bytes (default: 100 MB)."
    inputBinding:
      position: 6
      prefix: --max-slice-size
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Output data in JSON format instead of tables."
    inputBinding:
      position: 7
      prefix: --json
  - id: identifier
    type: string
    doc: "Id for dataset (e.g. EGAD00000000001) or file (e.g. EGAF12345678901)"
    inputBinding:
      position: 30
  - id: reference_name
    type:
      - 'null'
      - string
    doc: "The reference sequence name, for example 'chr1', '1', or 'chrX'. If unspecified, all data is returned."
    inputBinding:
      position: 11
      prefix: --reference-name
  - id: reference_md5
    type:
      - 'null'
      - string
    doc: "The MD5 checksum uniquely representing the requested reference sequence as a lower-case hexadecimal string."
    inputBinding:
      position: 12
      prefix: --reference-md5
  - id: start
    type:
      - 'null'
      - int
    doc: "The start position of the range on the reference, 0-based, inclusive. If specified, reference-name or reference-md5 must also be specified."
    inputBinding:
      position: 13
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: "The end position of the range on the reference, 0-based exclusive. If specified, reference-name or reference-md5 must also be specified."
    inputBinding:
      position: 14
      prefix: --end
  - id: format
    type:
      - 'null'
      - string
    doc: "The format of data to request (BAM, CRAM, VCF or BCF)."
    inputBinding:
      position: 15
      prefix: --format
  - id: max_retries
    type:
      - 'null'
      - int
    doc: "The maximum number of times to retry a failed transfer. Any negative number means infinite number of retries."
    inputBinding:
      position: 16
      prefix: --max-retries
  - id: retry_wait
    type:
      - 'null'
      - int
    doc: "The number of seconds to wait before retrying a failed transfer."
    inputBinding:
      position: 17
      prefix: --retry-wait
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Output directory. The files will be saved into this directory. Default: the current working directory."
    inputBinding:
      position: 18
      prefix: --output-dir
  - id: delete_temp_files
    type:
      - 'null'
      - boolean
    doc: "Do not keep those temporary, partial files which were left on the disk after a failed transfer."
    inputBinding:
      position: 19
      prefix: --delete-temp-files
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fetched_files
    type:
      type: array
      items: File
    doc: "Downloaded files in the output directory (or the working directory)."
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir + '/**' : '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: "$(inputs.output_dir ? inputs.output_dir : 'unused')"
        entry: "$(inputs.output_dir ? {class: 'Directory', basename: inputs.output_dir, listing: []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
stdout: pyega3_fetch.out
