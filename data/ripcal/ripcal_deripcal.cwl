cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deripcal
label: ripcal_deripcal
doc: "deRIPCAL is a command line companion tool to RIPCAL for the creation of a virtually de-RIP-mutated consensus sequence derived from a multiple alignment (fasta or clustalw aln format). The output is a multiple alignment in fasta format with the deRIPped consensus model sequence first.\n\nTool homepage: https://sourceforge.net/projects/ripcal"
inputs:
  - id: format
    type: string
    doc: Input format, fasta OR clustalw
    inputBinding:
      position: 1
  - id: input_alignment
    type: File
    doc: Multiple alignment in pearson/fasta (default) or clustalw aln format
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: Name of the output multiple alignment file (fasta format, deRIPped 
      consensus first)
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_alignment
    type: File
    doc: Multiple alignment in fasta format with the deRIPped consensus model first
    outputBinding:
      glob: $(inputs.output)
  - id: deripcons
    type: File
    doc: The deRIPped consensus sequence (fasta)
    outputBinding:
      glob: $(inputs.output).deripcons
  - id: consensus
    type: File
    doc: The plain consensus sequence (fasta)
    outputBinding:
      glob: $(inputs.output)consensus
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ripcal:2.0--hdfd78af_0
stdout: ripcal_deripcal.out
