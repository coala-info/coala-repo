cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_gene_caller
label: ppanini_gene_caller
doc: "PPANINI gene caller: calls genes on contigs, maps them to UniRef90 and quantifies them with reads.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: contig
    type: File
    doc: "Contigs file (fna)"
    inputBinding:
      position: 101
      prefix: -i
  - id: fastq
    type: File
    doc: "Reads file (fastq)"
    inputBinding:
      position: 101
      prefix: -f
  - id: uniref
    type: File
    doc: "UniRef90 database"
    inputBinding:
      position: 101
      prefix: -u
  - id: output_basename
    type:
      - 'null'
      - string
    doc: "The basename for the output files [DEFAULT: input file basename]"
    inputBinding:
      position: 101
      prefix: --output-basename
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
  - id: one_contig
    type:
      - 'null'
      - boolean
    doc: "If there is only one contig file for all samples, then this option should be provided"
    inputBinding:
      position: 101
      prefix: --one-contig
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
    doc: "Directory with the txt, gff and faa files of the sample"
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
stdout: ppanini_gene_caller.out
