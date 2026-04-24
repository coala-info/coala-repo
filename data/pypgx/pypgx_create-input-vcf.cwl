cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - create-input-vcf
label: pypgx_create-input-vcf
doc: "Call SNVs/indels from BAM files for all target genes.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: vcf
    type: File
    doc: Output VCF file. It must have .vcf.gz as suffix.
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Reference FASTA file.
    inputBinding:
      position: 2
  - id: bams
    type:
      type: array
      items: File
    doc: One or more input BAM files. Alternatively, you can provide a text file
      (.txt, .tsv, .csv, or .list) containing one BAM file per line.
    inputBinding:
      position: 3
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    inputBinding:
      position: 104
      prefix: --assembly
  - id: dir_path
    type:
      - 'null'
      - Directory
    doc: By default, intermediate files (likelihoods.bcf, calls.bcf, and 
      calls.normalized.bcf) will be stored in a temporary directory, which is 
      automatically deleted after creating final VCF. If you provide a directory
      path, intermediate files will be stored there.
    inputBinding:
      position: 104
      prefix: --dir-path
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified genes. Ignored when --genes is not used.
    inputBinding:
      position: 104
      prefix: --exclude
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genes to include.
    inputBinding:
      position: 104
      prefix: --genes
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "At a position, read maximally this number of reads per input file (default:
      250). If your input data is from WGS (e.g. 30X), you don't need to change this
      option. However, if it's from targeted sequencing with ultra-deep coverage (e.g.
      500X), then you need to increase the maximum depth."
    inputBinding:
      position: 104
      prefix: --max-depth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_create-input-vcf.out
