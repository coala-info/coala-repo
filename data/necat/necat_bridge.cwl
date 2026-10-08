cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - necat
  - bridge
label: necat_bridge
doc: "bridge contigs (runs correction and assembly first when they are not done yet)\n\nUsage: necat.pl correct|assemble|bridge|config cfg_fname. The config file (see necat_config) must name the read list by its file name (ONT_READ_LIST=<read_list basename>), and the read list must name the reads by their file names; the CWL stages the read list and reads in the working directory so these names resolve. The project folder (PROJECT) is written in the working directory; it stores absolute paths, so each command reruns the earlier steps from the reads.\n\nTool homepage: https://github.com/xiaochuanle/NECAT"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.read_list)
      - $(inputs.reads)
inputs:
  - id: config_file
    type: File
    doc: NECAT config file (cfg_fname)
    loadContents: true
    inputBinding:
      position: 1
  - id: read_list
    type: File
    doc: Read list file named by ONT_READ_LIST in the config; one read file name per line
  - id: reads
    type:
      type: array
      items: File
    doc: Raw read files (FASTA/FASTQ, may be gzipped) named in the read list
outputs:
  - id: project_output
    type: Directory
    doc: NECAT project folder
    outputBinding:
      glob: "$(inputs.config_file.contents.match(/^\\s*PROJECT=\\s*(\\S+)/m)[1])"
  - id: bridged_contigs
    type: File
    doc: Bridged contigs
    outputBinding:
      glob: "$(inputs.config_file.contents.match(/^\\s*PROJECT=\\s*(\\S+)/m)[1])/6-bridge_contigs/bridged_contigs.fasta"
  - id: polished_contigs
    type: ['null', File]
    doc: Polished bridged contigs (when POLISH_CONTIGS=true)
    outputBinding:
      glob: "$(inputs.config_file.contents.match(/^\\s*PROJECT=\\s*(\\S+)/m)[1])/6-bridge_contigs/polished_contigs.fasta"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
