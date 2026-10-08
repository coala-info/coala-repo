cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntLink_rounds
label: ntlink_ntLink_rounds
doc: "ntLink: Scaffolding assemblies using long reads - running iterative rounds of ntLink
  (run_rounds, or run_rounds_gaps with gap-filling).\n\nTool homepage: https://github.com/bcgsc/ntLink"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.target)
      - $(inputs.reads)
inputs:
  - id: gap_fill
    type:
      - 'null'
      - boolean
    doc: Run rounds with gap-filling (run_rounds_gaps) instead of run_rounds
    inputBinding:
      position: 1
      valueFrom: "$(self ? 'run_rounds_gaps' : 'run_rounds')"
    default: false
  - id: target
    type: File
    doc: Target assembly to be scaffolded in fasta format
    inputBinding:
      position: 2
      prefix: target=
      separate: false
      valueFrom: $(self.basename)
  - id: reads
    type:
      type: array
      items: File
    doc: List of long read files
    inputBinding:
      position: 3
      valueFrom: "${ return 'reads=' + self.map(function(f){ return f.basename; }).join(' '); }"
  - id: rounds
    type:
      - 'null'
      - int
    doc: Number of rounds of ntLink [5]
    inputBinding:
      position: 4
      prefix: rounds=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [4]
    inputBinding:
      position: 4
      prefix: t=
      separate: false
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer size for minimizers [32]
    inputBinding:
      position: 4
      prefix: k=
      separate: false
  - id: w
    type:
      - 'null'
      - int
    doc: Window size for minimizers [100]
    inputBinding:
      position: 4
      prefix: w=
      separate: false
  - id: z
    type:
      - 'null'
      - int
    doc: Minimum size of contig (bp) to scaffold [1000]
    inputBinding:
      position: 4
      prefix: z=
      separate: false
  - id: v
    type:
      - 'null'
      - int
    doc: If 1, track time and memory for each step of the pipeline [0]
    inputBinding:
      position: 4
      prefix: v=
      separate: false
  - id: dev
    type:
      - 'null'
      - boolean
    doc: Development run - retain intermediate files (no clean) [False]
    inputBinding:
      position: 4
      valueFrom: "${ return self == null ? null : (self ? 'dev=True' : 'dev=False'); }"
outputs:
  - id: scaffolds
    type: File
    doc: Final scaffolds after all rounds (<target>.k<k>.w<w>.z<z>.ntLink.<rounds>rounds.fa)
    outputBinding:
      glob: $(inputs.target.basename).k*.ntLink.*rounds.fa
  - id: agp
    type:
      type: array
      items: File
    doc: AGP files describing the scaffolds
    outputBinding:
      glob: '*.agp'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntlink:1.3.11--py312h7896c42_1
