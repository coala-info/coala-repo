cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie.pl
label: snpgenie_snpgenie.pl
doc: "SNPGenie: Estimating Evolutionary Parameters from SNPs!\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: fastafile
    type: File
    doc: FASTA file containing exactly one (1) reference sequence. All positions
      in the SNP report must correspond to one position in this sequence.
    inputBinding:
      position: 101
      prefix: --fastafile
  - id: gtffile
    type: File
    doc: tab-delimited Gene Transfer Format file containing non-redundant 
      records for all "CDS" elements (i.e., open reading frames, or ORFs) 
      present in the SNP report(s).
    inputBinding:
      position: 101
      prefix: --gtffile
  - id: minfreq
    type:
      - 'null'
      - float
    doc: minimum SNP frequency to consider when calculating diversity measures; 
      useful if SNPs below a certain frequency are likely to be errors.
    default: 0
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: snpreport
    type: File
    doc: CLC, Geneious, or VCF file containing SNP data with respect to 
      positions in the provided reference sequence (FASTA). If VCF, the exact 
      format must be specified (see documentation).
    inputBinding:
      position: 101
      prefix: --snpreport
  - id: vcfformat
    type:
      - 'null'
      - string
    doc: format ID of the VCF file (see documentation). Format 4 is the only 
      option which provides support for concurrent analysis of multiple samples.
    inputBinding:
      position: 101
      prefix: --vcfformat
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: user-specified working directory name.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: user-specified output directory name. Unless a full path, is given, the
      directory will be created in the working directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
