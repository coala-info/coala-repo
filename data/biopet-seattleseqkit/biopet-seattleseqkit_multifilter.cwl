cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-seattleseqkit
  - multifilter
label: biopet-seattleseqkit_multifilter
doc: "Filters SeattleSeq files of several samples, writes <sample>.tsv and <sample>.genes.tsv
  per sample, and merged genes.tsv and genes.multi_sample.tsv tables. A bed file
  per sample selects only variants inside its regions; filtering on specific fields
  is also possible.\n\nTool homepage: https://github.com/biopet/seattleseqkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: --inputFile
        valueFrom: $(self.nameroot)=$(self.path)
    doc: Seattle seq input files. Each file is passed as <sample>=<file>; the 
      sample name is the file name without its last extension.
    inputBinding:
      position: 101
  - id: output_dir_name
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: multi_sample_treshold
    type:
      - 'null'
      - int
    doc: 'Minimal number of samples per gene, default: 2'
    inputBinding:
      position: 101
      prefix: --multiSampleTreshold
  - id: gene_colapse_output
    type:
      - 'null'
      - string
    doc: Output file to count per gene hits
    inputBinding:
      position: 101
      prefix: --geneColapseOutput
  - id: intervals
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --intervals
          valueFrom: $(self.nameroot)=$(self.path)
    doc: Intervals bed file per sample. Each file is passed as <sample>=<file>; 
      the file name without its last extension must be the sample name.
    inputBinding:
      position: 101
  - id: field_must_contain
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fieldMustContain
    doc: Field must contain given text, given as <field>=<text>
    inputBinding:
      position: 101
  - id: field_must_be_below
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fieldMustBeBelow
    doc: Field must be below given numeric value, given as <field>=<double>
    inputBinding:
      position: 101
  - id: field_must_be_above
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fieldMustBeAbove
    doc: Field must be above given numeric value, given as <field>=<double>
    inputBinding:
      position: 101
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with per-sample and merged tables
    outputBinding:
      glob: $(inputs.output_dir_name)
  - id: gene_counts
    type:
      - 'null'
      - File
    doc: Hit counts per gene
    outputBinding:
      glob: $(inputs.gene_colapse_output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir_name, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
