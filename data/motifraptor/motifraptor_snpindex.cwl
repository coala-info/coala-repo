cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - snpindex
label: motifraptor_snpindex
doc: "Index the SNPs (with flanking sequences)\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: vcf_filename
    type:
      - 'null'
      - File
    doc: "input - VCF file for SNPs, first five columns need to be CHR,POS,ID,REF,ALT"
    inputBinding:
      position: 1
      prefix: -vcf
  - id: indexed_genome_db
    type:
      - 'null'
      - string
    doc: "output - indexed genome_database_folder"
    inputBinding:
      position: 1
      prefix: -gi
  - id: mksary_path
    type:
      - 'null'
      - string
    doc: "Mksary program path"
    inputBinding:
      position: 1
      prefix: -mk
  - id: thread_num
    type:
      - 'null'
      - int
    doc: "number of threads"
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory (the working directory of the run)"
    outputBinding:
      glob: $(inputs.indexed_genome_db)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_snpindex.out
