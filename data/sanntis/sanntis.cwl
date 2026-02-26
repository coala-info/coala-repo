cwlVersion: v1.2
class: CommandLineTool
baseCommand: sanntis
label: sanntis
doc: "SMBGC detection tool\n\nTool homepage: https://github.com/Finn-Lab/SanntiS"
inputs:
  - id: sequence_file
    type: File
    doc: 'Input sequence file. Supported formats: nucleotide FASTA, GBK, or protein
      FASTA. If the file is a protein FASTA, it must use Prodigal output headers and
      must be accompanied by the --is_protein flag. Mandatory.'
    inputBinding:
      position: 1
  - id: antismash_output
    type:
      - 'null'
      - boolean
    doc: Write results in antiSMASH 6.0 JSON specification output
    default: false
    inputBinding:
      position: 102
      prefix: --antismash_output
  - id: cpu
    type:
      - 'null'
      - int
    doc: Cpus for INTERPROSCAN and HMMSCAN
    inputBinding:
      position: 102
      prefix: --cpu
  - id: greed
    type:
      - 'null'
      - int
    doc: Level of greediness. 0,1,2
    default: 1
    inputBinding:
      position: 102
      prefix: --greed
  - id: interproscan_gff3_file
    type:
      - 'null'
      - File
    doc: Optional, preprocessed InterProScan GFF3 output file. Requires a GBK 
      file as SEQUENCE_FILE. The GBK must have CDS as features, and "protein_id"
      matching the ids in the InterProScan file. The GBK file can be build with 
      sanntis_build_gb tool
    inputBinding:
      position: 102
      prefix: --ip-file
  - id: is_protein
    type:
      - 'null'
      - boolean
    doc: Specify if the input SEQUENCE_FILE is a protein FASTA file. Will only 
      process sequences with headers formatted like Prodigal protein outputs.
    inputBinding:
      position: 102
      prefix: --is_protein
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Prodigal option meta
    default: true
    inputBinding:
      position: 102
      prefix: --meta
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: Minimal output in a gff3 file
    default: true
    inputBinding:
      position: 102
      prefix: --minimal
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: $PWD/SEQUENCE_FILE.sanntis
    inputBinding:
      position: 102
      prefix: --outdir
  - id: refined
    type:
      - 'null'
      - boolean
    doc: Annotate high probability borders
    default: false
    inputBinding:
      position: 102
      prefix: --refined
  - id: score
    type:
      - 'null'
      - float
    doc: Validation filter threshold. overrides --greed
    inputBinding:
      position: 102
      prefix: --score
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanntis:0.9.4.1--pyhdfd78af_0
