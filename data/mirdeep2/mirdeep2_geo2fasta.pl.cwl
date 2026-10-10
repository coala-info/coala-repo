cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - geo2fasta.pl
label: mirdeep2_geo2fasta.pl
doc: "Read all deflated GEO sample files (<prefix>*.txt with a sequence and a read count per line) and write one fasta file with the valid sequences\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: prefix
    type: string
    doc: Prefix of the sample files, for example GSM; all <prefix>*.txt files in the working directory are read
    inputBinding:
      position: 1
  - id: sample_files
    type:
      type: array
      items: File
    doc: Sample files (<prefix>*.txt) staged in the working directory
outputs:
  - id: fasta
    type: stdout
    doc: All valid reads in fasta format; each read is repeated by its count
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.sample_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: reads.fa
