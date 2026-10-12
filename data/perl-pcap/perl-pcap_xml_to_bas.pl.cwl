cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_to_bas.pl
label: perl-pcap_xml_to_bas.pl
doc: "Download the metadata XML of a GNOS analysis and convert it into a .bas statistics file\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: uri
    type:
      - 'null'
      - string
    doc: "Same URI used by gtdownload"
    inputBinding:
      position: 101
      prefix: -uri
  - id: output
    type:
      - 'null'
      - string
    doc: "Name for output file (default is standard output)"
    inputBinding:
      position: 101
      prefix: -output
  - id: bam
    type:
      - 'null'
      - File
    doc: "BAM|CRAM file this data relates to; checks the retrieved data correlates with the expected BAM"
    inputBinding:
      position: 101
      prefix: -bam
  - id: local_path
    type:
      - 'null'
      - File
    doc: "Local file path for XML from GNOS"
    inputBinding:
      position: 101
      prefix: -local-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Statistics file written with the output option"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_xml_to_bas.pl.out
