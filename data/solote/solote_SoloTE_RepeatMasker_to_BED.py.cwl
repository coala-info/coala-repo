cwlVersion: v1.2
class: CommandLineTool
baseCommand: SoloTE_RepeatMasker_to_BED.py
label: solote_SoloTE_RepeatMasker_to_BED.py
doc: "Downloads the RepeatMasker annotation of a UCSC genome assembly and converts
  it to a BED file of transposable elements (LINE, SINE, LTR, DNA, RC).\n\nTool homepage:
  https://github.com/bvaldebenitom/SoloTE"
inputs:
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome assembly identifier to obtain RepeatMasker annotation
      (available genomes can be checked with option -l).
    inputBinding:
      position: 1
      prefix: --genome
  - id: list_genomes
    type:
      - 'null'
      - boolean
    doc: List available genomes at the UCSC database.
    inputBinding:
      position: 1
      prefix: --list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log, or the genome list with --list)
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: BED file of repeat elements, named <genome>_rmsk.bed
    outputBinding:
      glob: '*_rmsk.bed'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solote:1.09--hdfd78af_0
stdout: solote_SoloTE_RepeatMasker_to_BED.py.out
