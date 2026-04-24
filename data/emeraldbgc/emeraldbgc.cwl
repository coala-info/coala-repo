cwlVersion: v1.2
class: CommandLineTool
baseCommand: emeraldbgc
label: emeraldbgc
doc: "EMERALD. SMBGC detection tool\n\nTool homepage: https://github.com/Finn-Lab/emeraldBGC"
inputs:
  - id: sequence_file
    type: File
    doc: input nucleotide sequence file. FASTA or GBK.
    inputBinding:
      position: 1
  - id: antismash_output
    type:
      - 'null'
      - boolean
    doc: write results in antiSMASH 6.0 JSON specification output
    inputBinding:
      position: 102
      prefix: --antismash_output
  - id: cpu
    type:
      - 'null'
      - int
    doc: cpus for INTERPROSCAN and HMMSCAN
    inputBinding:
      position: 102
      prefix: --cpu
  - id: greed
    type:
      - 'null'
      - int
    doc: Level of greediness. 0,1,2
    inputBinding:
      position: 102
      prefix: --greed
  - id: ip_file
    type:
      - 'null'
      - File
    doc: Optional, preprocessed InterProScan GFF3 output file. Requires a GBK 
      file as SEQUENCE_FILE. The GBK must have CDS as features, and "protein_id"
      matching the ids in the InterProScan file. The GBK file can be build with 
      emerald_build_gb tool
    inputBinding:
      position: 102
      prefix: --ip-file
  - id: meta
    type:
      - 'null'
      - boolean
    doc: prodigal option meta
    inputBinding:
      position: 102
      prefix: --meta
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: minimal output in a gff3 file
    inputBinding:
      position: 102
      prefix: --minimal
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: refined
    type:
      - 'null'
      - boolean
    doc: annotate high probability borders
    inputBinding:
      position: 102
      prefix: --refined
  - id: score
    type:
      - 'null'
      - float
    doc: validation filter threshold. overrides --greed
    inputBinding:
      position: 102
      prefix: --score
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emeraldbgc:0.2.4.1--pyhdfd78af_0
