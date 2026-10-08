cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapless.py
  - scaffold
label: gapless_scaffold
doc: "Scaffolds contigs and assigns reads to gaps.\n\nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: assembly
    type: File
    doc: "Split assembly in FASTA format ({assembly}.fa)"
    inputBinding:
      position: 2
  - id: mapping
    type: File
    doc: "Mapping of the long reads to the assembly ({mapping}.paf)"
    inputBinding:
      position: 3
  - id: repeat
    type: File
    doc: "Self-mapping of the assembly to detect repeats ({repeat}.paf)"
    inputBinding:
      position: 4
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files ({assembly})"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: stats
    type:
      - 'null'
      - string
    doc: "Output file for plots with statistics regarding input parameters (deactivated)"
    inputBinding:
      position: 1
      prefix: --stats
  - id: min_len_break
    type:
      - 'null'
      - int
    doc: "Minimum length for a read to diverge from a contig to consider a contig break (600)"
    inputBinding:
      position: 1
      prefix: --minLenBreak
  - id: min_map_length
    type:
      - 'null'
      - int
    doc: "Minimum length of individual mappings of reads (400)"
    inputBinding:
      position: 1
      prefix: --minMapLength
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality of reads (20)"
    inputBinding:
      position: 1
      prefix: --minMapQ
outputs:
  - id: scaffold_files
    type:
      type: array
      items: File
    doc: Scaffolding files written with the prefix (scaffold paths, read lists, statistics)
    outputBinding:
      glob: '${ return (inputs.prefix ? inputs.prefix : inputs.assembly.nameroot) + "*"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
