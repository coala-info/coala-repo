cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - download
label: yasma_download
doc: "Download libraries from the NCBI SRA using their SRR code\n\nTool homepage:
  https://github.com/NateyJay/YASMA"
inputs:
  - id: include_quals
    type:
      - 'null'
      - boolean
    doc: Download libraries as .fastq format (default is only .fasta)
    inputBinding:
      position: 101
      prefix: --include_quals
  - id: output_directory
    type: Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    inputBinding:
      position: 101
      prefix: --output_directory
      valueFrom: $(self.basename)
  - id: srrs
    type:
      type: array
      items: string
      inputBinding:
        prefix: --srrs
    doc: NCBI SRA codes for libraries. These will almost certainly start with 
      SRR or ERR.
    inputBinding:
      position: 101
  - id: unzipped
    type:
      - 'null'
      - boolean
    doc: Whether to compress downloaded files (default is uncompressed)
    inputBinding:
      position: 101
      prefix: --unzipped
  - id: zipped
    type:
      - 'null'
      - boolean
    doc: Whether to compress downloaded files (default is uncompressed)
    inputBinding:
      position: 101
      prefix: --zipped
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
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{entry: inputs.output_directory, writable: true}];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_download.out
