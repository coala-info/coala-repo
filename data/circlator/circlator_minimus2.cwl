cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circlator
  - minimus2
label: circlator_minimus2
doc: "Runs minimus2 circularisation pipeline, see https://github.com/PacificBiosciences/Bioinformatics-Training/wiki/Circularising-and-trimming
  ... this script is a modified version of that protocol. It first runs minimus2 on
  the input contigs (unless --no_pre_merge is used). Then it tries to circularise
  each contig one at a time, by breaking it in the middle and using the two pieces
  as input to minimus2. If minimus2 outputs one contig, then that new one is assumed
  to be circularised and is kept, otherwise the original contig is kept.\n\nTool homepage:
  https://github.com/sanger-pathogens/circlator"
inputs:
  - id: assembly_fasta
    type: File
    doc: Name of original assembly
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 2
  - id: no_pre_merge
    type:
      - 'null'
      - boolean
    doc: Do not do initial minimus2 run before trying to circularise each contig
    inputBinding:
      position: 103
      prefix: --no_pre_merge
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_minimus2.out
