cwlVersion: v1.2
class: CommandLineTool
baseCommand: konezumiaid
label: konezumiaid
doc: "Designs gRNAs for multiplex KO mouse with Target-AID. Searches candidate gRNAs
  that create a premature termination codon or disrupt a splice site for one gene
  symbol or one RefSeq transcript name. Run konezumiaid preprocess first.\n\nTool
  homepage: https://github.com/aki2274/KOnezumi-AID"
inputs:
  - id: name
    type: string
    doc: Gene name or transcript name (RefSeq ID) you want to design gRNAs for
    inputBinding:
      position: 1
      prefix: --name
  - id: konezumiaid_data
    type: Directory
    doc: Dataset folder made by konezumiaid preprocess (staged as konezumiaid_data)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the gRNA tables
  - id: gRNA_output
    type:
      - 'null'
      - Directory
    doc: Folder with the gRNA tables in CSV format
    outputBinding:
      glob: konezumiaid_data/output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.konezumiaid_data)
        entryname: konezumiaid_data
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
stdout: konezumiaid.out
