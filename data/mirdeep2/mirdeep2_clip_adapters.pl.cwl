cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clip_adapters.pl
label: mirdeep2_clip_adapters.pl
doc: "Remove 3' adapters from deep sequencing reads in a fasta file; works in sequence space\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: reads
    type: File
    doc: Fasta file with the reads
    inputBinding:
      position: 1
  - id: adapter
    type: string
    doc: "3' adapter sequence to clip"
    inputBinding:
      position: 2
outputs:
  - id: clipped_reads
    type: stdout
    doc: Reads in fasta format with the adapter removed
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: clipped_reads.fa
