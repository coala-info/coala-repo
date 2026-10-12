cwlVersion: v1.2
class: CommandLineTool
baseCommand: xam_coverage_bins.pl
label: perl-pcap_xam_coverage_bins.pl
doc: "Report the coverage of target regions from a BAM/CRAM file in depth bins as a JSON string\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: xam_file
    type: File
    secondaryFiles:
      - '.bai?'
    doc: "bam|cram file to check coverage"
    inputBinding:
      position: 101
      prefix: -xam_file
  - id: target_file
    type: File
    doc: "bed|gff3 file of targets"
    inputBinding:
      position: 101
      prefix: -target_file
  - id: type
    type: string
    doc: "Type of target file provided (bed or gff3)"
    inputBinding:
      position: 101
      prefix: -type
  - id: output_file
    type: string
    doc: "File to write the JSON string output of coverage"
    inputBinding:
      position: 101
      prefix: -output_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: coverage_json
    type: File
    doc: "File with the coverage bins"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_xam_coverage_bins.pl.out
