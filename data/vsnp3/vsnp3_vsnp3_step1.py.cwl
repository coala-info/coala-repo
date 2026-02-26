cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_step1.py
label: vsnp3_vsnp3_step1.py
doc: "When running samples through step1 and 2 of vSNP, or when running a routine
  analysis, set up dependencies using vsnp3_path_adder.py\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: assemble_unmap
    type:
      - 'null'
      - boolean
    doc: 'Optional: skip assembly of unmapped reads. See also vsnp3_assembly.py'
    inputBinding:
      position: 101
      prefix: --assemble_unmap
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep spades output directory
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file to be used as reference. Multiple can be specified with 
      wildcard
    inputBinding:
      position: 101
      prefix: --FASTA
  - id: fasta_to_fastq
    type:
      - 'null'
      - File
    doc: Input a FASTA file, convert to paired FASTQ files, and run.
    inputBinding:
      position: 101
      prefix: --FASTAtoFASTQ
  - id: fastq_r1
    type:
      - 'null'
      - File
    doc: Provide R1 FASTQ gz file. A single read file can also be supplied to 
      this option
    inputBinding:
      position: 101
      prefix: --FASTQ_R1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: 'Optional: provide R2 FASTQ gz file'
    inputBinding:
      position: 101
      prefix: --FASTQ_R2
  - id: gbk
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: gbk to annotate VCF file. Multiple can be specified with wildcard'
    inputBinding:
      position: 101
      prefix: --gbk
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: if true run alignment optimized for nanopore reads
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Optional: Provide a name. This name will be a directory output files are
      written to. Name can be a directory path, but doesn't have to be."
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: reference_type
    type:
      - 'null'
      - string
    doc: 'Optional: Provide directory name with FASTA and GBK file/s'
    inputBinding:
      position: 101
      prefix: --reference_type
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Force output files to this sample name
    inputBinding:
      position: 101
      prefix: --SAMPLE_NAME
  - id: spoligo
    type:
      - 'null'
      - boolean
    doc: 'Optional: get spoligotype if TB complex. See also vsnp3_spoligotype.py'
    inputBinding:
      position: 101
      prefix: --spoligo
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_step1.py.out
