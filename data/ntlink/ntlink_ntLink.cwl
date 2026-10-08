cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ntLink
  - scaffold
label: ntlink_ntLink
doc: "ntLink: Scaffolding assemblies using long reads. Runs `ntLink scaffold` (optionally
  with gap filling) on a target assembly and long reads.\n\nTool homepage: https://github.com/bcgsc/ntLink"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.target)
      - $(inputs.reads)
inputs:
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
  - id: gap_fill
    type:
      - 'null'
      - boolean
    doc: Additionally run gap-filling (fill gap regions with raw read sequence)
    inputBinding:
      position: 1
      prefix: gap_fill
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of intermediate output files [<target>.k<k>.w<w>.z<z>]
    inputBinding:
      position: 4
      prefix: prefix=
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
  - id: n
    type:
      - 'null'
      - int
    doc: Minimum graph edge weight [1]
    inputBinding:
      position: 4
      prefix: n=
      separate: false
  - id: min_gap
    type:
      - 'null'
      - int
    doc: Minimum gap size (bp) [20]
    inputBinding:
      position: 4
      prefix: g=
      separate: false
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap size (bp). -1 indicates no maximum [-1]
    inputBinding:
      position: 4
      prefix: G=
      separate: false
  - id: f
    type:
      - 'null'
      - int
    doc: Maximum number of contigs in a run for full transitive edge addition [10]
    inputBinding:
      position: 4
      prefix: f=
      separate: false
  - id: a
    type:
      - 'null'
      - int
    doc: Minimum number of anchored ONT reads required for an edge [1]
    inputBinding:
      position: 4
      prefix: a=
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
  - id: paf
    type:
      - 'null'
      - boolean
    doc: If True, outputs read to contig mappings in PAF-like format [False]
    inputBinding:
      position: 4
      valueFrom: "${ return self == null ? null : (self ? 'paf=True' : 'paf=False'); }"
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: If True, runs extra step to attempt to identify and trim overlapping joined
      sequences [True]
    inputBinding:
      position: 4
      valueFrom: "${ return self == null ? null : (self ? 'overlap=True' : 'overlap=False'); }"
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: If True, runs mapping in sensitive mode [False]
    inputBinding:
      position: 4
      valueFrom: "${ return self == null ? null : (self ? 'sensitive=True' : 'sensitive=False'); }"
  - id: soft_mask
    type:
      - 'null'
      - boolean
    doc: If True, gaps are filled with lowercase bases [False]
    inputBinding:
      position: 4
      valueFrom: "${ return self == null ? null : (self ? 'soft_mask=True' : 'soft_mask=False'); }"
outputs:
  - id: scaffolds
    type: File
    doc: Final post-ntLink scaffolds (<target>.k<k>.w<w>.z<z>.ntLink.scaffolds.fa)
    outputBinding:
      glob: $(inputs.target.basename).k*.ntLink.scaffolds.fa
  - id: gap_filled_scaffolds
    type:
      - 'null'
      - File
    doc: Gap-filled scaffolds (with gap_fill)
    outputBinding:
      glob: $(inputs.target.basename).k*.ntLink.scaffolds.gap_fill.fa
  - id: agp
    type:
      type: array
      items: File
    doc: AGP files describing the scaffolds
    outputBinding:
      glob: '*.agp'
  - id: verbose_mapping
    type:
      type: array
      items: File
    doc: Verbose read-to-contig mappings
    outputBinding:
      glob: '*.verbose_mapping.tsv'
  - id: paf_mappings
    type:
      type: array
      items: File
    doc: Read to contig mappings in PAF-like format (with paf)
    outputBinding:
      glob: '*.paf'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntlink:1.3.11--py312h7896c42_1
