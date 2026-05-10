cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner bin
label: deepbinner_bin
doc: "Bin fasta/q reads\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: classes
    type: File
    doc: Deepbinner classification file (made with the deepbinner classify 
      command)
    inputBinding:
      position: 101
      prefix: --classes
  - id: reads
    type: File
    doc: FASTA or FASTQ reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: out_dir_path
    type: Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
outputs:
  - id: out_dir
    type: Directory
    doc: Directory to output binned read files
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
