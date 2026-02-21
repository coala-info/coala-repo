cwlVersion: v1.2
class: CommandLineTool
baseCommand: tifffile
label: tifffile
doc: "Read and write TIFF(r) files. (Note: The provided text appears to be a container
  build error log rather than help text; no arguments could be extracted from the
  input.)\n\nTool homepage: https://github.com/cgohlke/tifffile"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tifffile:v20181128-1-deb_cv1
stdout: tifffile.out
