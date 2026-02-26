cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agfusion
  - annotate
label: agfusion_annotate
doc: "Annotate and visualize gene fusion events using the AGFusion database.\n\nTool
  homepage: https://github.com/murphycj/AGFusion"
inputs:
  - id: database
    type: File
    doc: Path to the AGFusion database (e.g. --db 
      /path/to/agfusion.homo_sapiens.87.db)
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: (Optional) Enable debugging logging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: dpi
    type:
      - 'null'
      - int
    doc: (Optional) Dots per inch.
    inputBinding:
      position: 101
      prefix: --dpi
  - id: exclude_domain
    type:
      - 'null'
      - type: array
        items: string
    doc: (Optional) Exclude a certain domain(s) from plotting by providing a 
      space-separated list of domain names.
    inputBinding:
      position: 101
      prefix: --exclude_domain
  - id: fontsize
    type:
      - 'null'
      - int
    doc: (Optional) Fontsize (default 12).
    default: 12
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: gene3prime
    type: string
    doc: 3' gene partner
    inputBinding:
      position: 101
      prefix: --gene3prime
  - id: gene5prime
    type: string
    doc: 5' gene partner
    inputBinding:
      position: 101
      prefix: --gene5prime
  - id: height
    type:
      - 'null'
      - float
    doc: (Optional) Image file height in inches (default 3).
    default: 3
    inputBinding:
      position: 101
      prefix: --height
  - id: junction3prime
    type: int
    doc: Genomic location of predicted fuins for the 3' gene partner. The 
      1-based position that is the first nucleotide included in the fusion after
      the junction.
    inputBinding:
      position: 101
      prefix: --junction3prime
  - id: junction5prime
    type: int
    doc: Genomic location of predicted fuins for the 5' gene partner. The 
      1-based position that is the last nucleotide included in the fusion before
      the junction.
    inputBinding:
      position: 101
      prefix: --junction5prime
  - id: middlestar
    type:
      - 'null'
      - boolean
    doc: (Optional) Insert a * at the junction position for the cdna, cds, and 
      protein sequences (default False).
    default: false
    inputBinding:
      position: 101
      prefix: --middlestar
  - id: no_domain_labels
    type:
      - 'null'
      - boolean
    doc: (Optional) Do not label domains.
    inputBinding:
      position: 101
      prefix: --no_domain_labels
  - id: noncanonical
    type:
      - 'null'
      - boolean
    doc: (Optional) Include non-canonical gene transcripts in the analysis 
      (default False).
    default: false
    inputBinding:
      position: 101
      prefix: --noncanonical
  - id: protein_databases
    type:
      - 'null'
      - type: array
        items: string
    doc: '(Optional) Space-delimited list of one or more protein feature databases
      to include when visualizing proteins. Options are: pfam, smart, superfamily,
      tigrfam, pfscan, tmhmm, seg, ncoils, prints, pirsf, and signalp.'
    inputBinding:
      position: 101
      prefix: --protein_databases
  - id: recolor
    type:
      - 'null'
      - type: array
        items: string
    doc: (Optional) Re-color a domain. Provide the original name of the domain 
      then your color (semi-colon delimited, all in quotes).
    inputBinding:
      position: 101
      prefix: --recolor
  - id: rename
    type:
      - 'null'
      - type: array
        items: string
    doc: (Optional) Rename a domain. Provide the original name of the domain 
      then your new name (semi-colon delimited, all in quotes).
    inputBinding:
      position: 101
      prefix: --rename
  - id: scale
    type:
      - 'null'
      - int
    doc: '(Optional) Set maximum width (in amino acids) of the figure to rescale the
      fusion (default: max length of fusion product)'
    inputBinding:
      position: 101
      prefix: --scale
  - id: type
    type:
      - 'null'
      - string
    doc: '(Optional) Image file type (png, jpeg, pdf). Default: png'
    default: png
    inputBinding:
      position: 101
      prefix: --type
  - id: width
    type:
      - 'null'
      - float
    doc: (Optional) Image width in inches (default 10).
    default: 10
    inputBinding:
      position: 101
      prefix: --width
  - id: wt
    type:
      - 'null'
      - boolean
    doc: (Optional) Include this to plot wild-type architechtures of the 5' and 
      3' genes
    inputBinding:
      position: 101
      prefix: --WT
outputs:
  - id: out
    type: Directory
    doc: Directory to save results
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agfusion:1.252--py_0
