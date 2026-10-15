cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_press
label: ppanini_press
doc: "PPANINI Press: clusters genes to gene families including annotated genes to UniRef90 and homology-based clustered genes.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: gene_path
    type: Directory
    doc: "A directory path to ppanini_gene_caller outputs which includes txt, gff, and faa files for each sample"
    inputBinding:
      position: 101
      prefix: -i
  - id: resume
    type:
      - 'null'
      - boolean
    doc: "Bypass commands if the output files exist"
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads/processes [DEFAULT: 1]"
    inputBinding:
      position: 101
      prefix: --threads
  - id: scale
    type:
      - 'null'
      - string
    doc: "Scale the abundance table: rpk or count"
    inputBinding:
      position: 101
      prefix: --scale
  - id: memory
    type:
      - 'null'
      - int
    doc: "Memory for the -M option in CD-HIT"
    inputBinding:
      position: 101
      prefix: --memory
  - id: output_path
    type: string
    doc: "Path for outputs"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: "Directory with the gene family table and cluster maps"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_press.out
