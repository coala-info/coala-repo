cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie.pl
label: snpgenie_snpgenie.pl
doc: "SNPGenie: Estimating Evolutionary Parameters from SNPs! Within-pool analysis
  of pi_N/pi_S from pooled NGS SNP data (CLC, Geneious or VCF SNP reports).\n\nTool homepage:
  https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: fastafile
    type: File
    doc: FASTA file containing exactly one (1) reference sequence. All positions in
      the SNP report must correspond to one position in this sequence.
    inputBinding:
      position: 101
      prefix: --fastafile
      valueFrom: $(self.basename)
  - id: gtffile
    type: File
    doc: tab-delimited Gene Transfer Format file containing non-redundant records
      for all "CDS" elements (i.e., open reading frames, or ORFs) present in the
      SNP report(s).
    inputBinding:
      position: 101
      prefix: --gtffile
      valueFrom: $(self.basename)
  - id: snpreport
    type: File
    doc: CLC, Geneious, or VCF file containing SNP data with respect to positions
      in the provided reference sequence (FASTA). If VCF, the exact format must be
      specified (see documentation).
    inputBinding:
      position: 101
      prefix: --snpreport
      valueFrom: $(self.basename)
  - id: vcfformat
    type:
      - 'null'
      - string
    doc: format ID of the VCF file (see documentation). Format 4 is the only option
      which provides support for concurrent analysis of multiple samples. Required
      if the SNP report is a VCF.
    inputBinding:
      position: 101
      prefix: --vcfformat
  - id: minfreq
    type:
      - 'null'
      - float
    doc: minimum SNP frequency to consider when calculating diversity measures; useful
      if SNPs below a certain frequency are likely to be errors.
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: workdir
    type:
      - 'null'
      - string
    doc: user-specified working directory name. Default is the current working
      directory, where the input files are staged.
    inputBinding:
      position: 101
      prefix: --workdir
  - id: outdir_path
    type:
      - 'null'
      - string
    doc: user-specified output directory name. Unless a full path is given, the
      directory will be created in the working directory. Default is SNPGenie_Results.
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir
    type: Directory
    doc: Results directory (population_summary.txt, product_results.txt, site_results.txt,
      codon_results.txt, SNPGenie_LOG.txt)
    outputBinding:
      glob: "$(inputs.outdir_path ? inputs.outdir_path : 'SNPGenie_Results')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fastafile)
      - $(inputs.gtffile)
      - $(inputs.snpreport)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie.pl.out
