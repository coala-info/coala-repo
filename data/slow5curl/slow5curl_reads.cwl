cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5curl
  - reads
label: slow5curl_reads
doc: "Prints the reads in a remote BLOW5 file.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
inputs:
  - id: slow5_file
    type: string
    doc: URL of the remote BLOW5 file
    inputBinding:
      position: 100
  - id: cache_file_path
    type: ['null', string]
    doc: Save the downloaded index to the specified file path
    inputBinding:
      position: 1
      prefix: --cache
  - id: index
    type: ['null', File, string]
    doc: Path (local file or URL) to a custom slow5 index
    inputBinding:
      position: 1
      prefix: --index
stdout: slow5curl_reads.out
outputs:
  - id: read_ids
    type: stdout
    doc: Read list printed by slow5curl reads
  - id: cache_file
    type: ['null', File]
    doc: Downloaded index saved with --cache
    outputBinding:
      glob: $(inputs.cache_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
