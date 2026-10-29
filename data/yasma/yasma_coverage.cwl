cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - coverage
label: yasma_coverage
doc: "Produces bigwig coverage files\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - string
    default: align/alignment.bam
    doc: Alignment file input (bam or cram). Give the path inside the project directory (output_directory); the depth table and index of the alignment must sit beside it.
    inputBinding:
      position: 101
      prefix: --alignment_file
      valueFrom: $(inputs.output_directory.basename)/$(self)
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Forces remaking bigwigs even if all expected\n                         \
      \        are found"
    inputBinding:
      position: 101
      prefix: --force
  - id: output_directory
    type: Directory
    doc: "Directory name for annotation output.\n                                \
      \ Defaults to the current directory, with this\n                           \
      \      directory name as the project name."
    inputBinding:
      position: 101
      prefix: --output_directory
      valueFrom: $(self.basename)
  - id: peaks
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --peaks
    doc: "Entry of size limits for a peak. Encoded as\n                          \
      \       two integers separated by a dash (`-`), for\n                      \
      \           example: 21-22 is an appropriate entry for\n                   \
      \              plant miRNAS. Also accepts single-size peaks\n              \
      \                   without dash. Multiple peaks may be\n                  \
      \               identified, separated with spaces or by\n                  \
      \               calling the option again."
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: project_directory
    type: Directory
    doc: Project directory with the files this step wrote
    outputBinding:
      glob: $(inputs.output_directory.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{entry: inputs.output_directory, writable: true}];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_coverage.out
