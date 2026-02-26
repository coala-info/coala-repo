cwlVersion: v1.2
class: CommandLineTool
baseCommand: optimir libprep
label: optimir_libprep
doc: "Prepare reference libraries for OptimiR.\n\nTool homepage: https://github.com/FlorianThibord/OptimiR"
inputs:
  - id: bowtie2_build
    type:
      - 'null'
      - string
    doc: Provide path to the bowtie2 index builder binary
    default: from $PATH
    inputBinding:
      position: 101
      prefix: --bowtie2_build
  - id: gff3
    type:
      - 'null'
      - File
    doc: Path to the reference library containing miRNAs and pri-miRNAs 
      coordinates
    default: miRBase v21, GRCh38 coordinates
    inputBinding:
      position: 101
      prefix: --gff3
  - id: hairpins_fasta
    type:
      - 'null'
      - File
    doc: Path to the reference library containing pri-miRNAs sequences
    default: miRBase 21
    inputBinding:
      position: 101
      prefix: --hairpinsFasta
  - id: matures_fasta
    type:
      - 'null'
      - File
    doc: Path to the reference library containing mature miRNAs sequences
    default: miRBase 21
    inputBinding:
      position: 101
      prefix: --maturesFasta
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Full path of the directory where output files are generated
    default: ./OptimiR_Results_Dir/
    inputBinding:
      position: 101
      prefix: --dirOutput
  - id: vcf
    type:
      - 'null'
      - File
    doc: Full path of the input VCF file.
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir_libprep.out
