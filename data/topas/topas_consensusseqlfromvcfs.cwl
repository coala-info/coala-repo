cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - topas
  - ConsensusSeqFromVCFs
label: topas_consensusseqlfromvcfs
doc: "generate a consensus sequence from the SNPs of several VCF files\n\nTool homepage:
  https://github.com/subwaystation/TOPAS"
inputs:
  - id: fasta
    type: File
    doc: The input path of the reference fasta file
    inputBinding:
      position: 1
      prefix: -fasta
      valueFrom: $(self.basename)
  - id: fai
    type: ['null', File]
    doc: The path to the reference fasta index file. If not given, a new one is generated.
    inputBinding:
      position: 2
      prefix: -fai
  - id: vcf_files
    type:
      type: array
      items: File
    doc: Input VCF file(s)
    inputBinding:
      position: 3
      prefix: -vcfs
  - id: output_file
    type: string
    doc: The output path of the consensus fasta file
    inputBinding:
      position: 4
      prefix: -o
  - id: ratio
    type: ['null', double]
    doc: The ratio from which the alternative base of a SNP is chosen as reference (default 0.8)
    inputBinding:
      position: 5
      prefix: -ratio
outputs:
  - id: consensus_fasta
    type: File
    doc: The consensus fasta file
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.fasta.basename)
        entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/topas:1.0.1--0
stdout: topas_consensusseqlfromvcfs.out
