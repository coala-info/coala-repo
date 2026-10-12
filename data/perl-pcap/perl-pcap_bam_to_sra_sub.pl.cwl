cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_to_sra_sub.pl
label: perl-pcap_bam_to_sra_sub.pl
doc: "Create SRA submission XML files for BAM files, to upload them to a GNOS repository\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "BAM files to prepare SRA submission XML for"
    inputBinding:
      position: 200
  - id: outdir
    type: string
    doc: "Folder to output result to"
    inputBinding:
      position: 101
      prefix: -outdir
  - id: gnos
    type: string
    doc: "GNOS upload server, for example https://gtrepo-ebi.annailabs.com"
    inputBinding:
      position: 101
      prefix: -gnos
  - id: study
    type:
      - 'null'
      - string
    doc: "Study reference in repository [icgc_pancancer]"
    inputBinding:
      position: 101
      prefix: -study
  - id: type
    type:
      - 'null'
      - string
    doc: "Sequencing type if not encoded in the readgroup LB tag (WGS, WXS or RNA-Seq)"
    inputBinding:
      position: 101
      prefix: -type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_out
    type: Directory
    doc: "Output folder with the SRA XML files"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_bam_to_sra_sub.pl.out
