cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_stats.pl
label: perl-pcap_bam_stats.pl
doc: "Generate a .bas statistics file (read, mapping and insert size statistics per read group) for a BAM file\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: input
    type: File
    doc: "BAM file to read"
    inputBinding:
      position: 101
      prefix: -input
  - id: output
    type:
      - 'null'
      - string
    doc: "File path to output data (default is standard output)"
    inputBinding:
      position: 101
      prefix: -output
  - id: plots
    type:
      - 'null'
      - string
    doc: "Folder to contain quality score plots (not available with -threads)"
    inputBinding:
      position: 101
      prefix: -plots
  - id: threads
    type:
      - 'null'
      - int
    doc: "Use multiple threads to process the input; the complete file is read for each thread"
    inputBinding:
      position: 101
      prefix: -threads
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
  - id: plots_dir
    type:
      - 'null'
      - Directory
    doc: "Quality score plots written with the plots option"
    outputBinding:
      glob: $(inputs.plots)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_bam_stats.pl.out
