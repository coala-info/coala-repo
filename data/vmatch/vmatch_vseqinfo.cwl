cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vseqinfo
label: vmatch_vseqinfo
doc: "Show information (number, length, description) on the sequences of a Vmatch index.\n\nTool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
inputs:
  - id: index_files
    type: File[]
    doc: "Index files written by mkvtree (staged in the working directory so the index name resolves)"
  - id: index_name
    type: string
    doc: "Name of the index (the mkvtree -indexname value)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_vseqinfo.out
