cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - scorer
label: astalavista_scorer
doc: "Splice site scorer tool from the Barna library\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: in_file
    type: File
    doc: Path to the GTF reference annotation
    inputBinding:
      position: 102
      prefix: --in
  - id: gene_id
    type: File
    doc: File with the GeneID models for splice sites (a GeneID parameter file)
    inputBinding:
      position: 102
      prefix: --gid
  - id: chr_seq
    type: Directory
    doc: Directory with the genomic sequences, one fasta file per chromosome/scaffold/contig
      named by the identifiers of the first column in the GTF annotation
    inputBinding:
      position: 102
      prefix: --chr
  - id: sites_file
    type: string
    doc: Path to the VCF output file for sites
    inputBinding:
      position: 102
      prefix: --so
  - id: sites
    type:
      - 'null'
      - string
    doc: Types of sites that are output
    inputBinding:
      position: 102
      prefix: --ss
  - id: sites_opt
    type:
      - 'null'
      - string
    doc: Toggle optional site attributes to be output
    inputBinding:
      position: 102
      prefix: --sp
  - id: variant_file
    type:
      - 'null'
      - File
    doc: File with the variant information (vcf)
    inputBinding:
      position: 102
      prefix: --vcf
  - id: par_file
    type:
      - 'null'
      - File
    doc: Path to the parameter file
    inputBinding:
      position: 102
      prefix: --par
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - string
    doc: Log level (NONE|INFO|ERROR|DEBUG)
    inputBinding:
      position: 101
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: sites_vcf
    type: File
    doc: Scored splice sites
    outputBinding:
      glob: $(inputs.sites_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
stdout: astalavista_scorer.out
