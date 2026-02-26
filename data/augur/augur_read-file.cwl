cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_read-file
label: augur_read-file
doc: "Read one or more files like Augur, with transparent optimized decompression
  and universal newlines. Supported compression formats: gzip (.gz), bzip2 (.bz2),
  xz (.xz), zstandard (.zst). Input is read from each given file path, as the compression
  format detection requires a seekable stream. A path may be \"-\" to explicitly read
  from stdin, but no decompression will be done. Output from each file is concatenated
  together and written to stdout. Universal newline translation is always performed,
  so \\n, \\r\\n, and \\r in the input are all translated to the system's native newlines
  (e.g. \\n on Unix, \\r\\n on Windows) in the output. Additionally, each file is
  standardized to have trailing newlines.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: paths
    type:
      type: array
      items: File
    doc: paths to files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_read-file.out
