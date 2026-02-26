cwlVersion: v1.2
class: CommandLineTool
baseCommand: baralign.sh
label: dunovo_baralign.sh
doc: "Aligns barcodes to a reference genome.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs:
  - id: families_file
    type: File
    doc: The families file produced by make-barcodes.awk and sorted.
    inputBinding:
      position: 1
  - id: refdir
    type:
      - 'null'
      - Directory
    doc: The directory to put the reference file ("barcodes.fa") and its index 
      files in.
    default: refdir
    inputBinding:
      position: 2
  - id: bowtie_chunkmbs
    type:
      - 'null'
      - int
    doc: Number to pass to bowtie's --chunkmbs option
    default: 512
    inputBinding:
      position: 103
      prefix: -c
  - id: no_reversed_barcodes
    type:
      - 'null'
      - boolean
    doc: Don't include reversed barcodes (alpha+beta -> beta+alpha) in the 
      alignment target.
    inputBinding:
      position: 103
      prefix: -R
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 103
      prefix: -q
  - id: report_platform_galaxy
    type:
      - 'null'
      - boolean
    doc: Report the platform as "galaxy" when sending usage data.
    inputBinding:
      position: 103
      prefix: -g
  - id: report_usage
    type:
      - 'null'
      - boolean
    doc: Report helpful usage data to the developer, to better understand the 
      use cases and performance of the tool. The only data which will be 
      recorded is the name and version of the tool, the size of the input data, 
      the time taken to process it, the IP address of the machine running it, 
      and some performance-related parameters (-t, -c, and the format of the 
      output file). No filenames are sent. All the reporting and recording code 
      is available at https://github.com/NickSto/ET.
    inputBinding:
      position: 103
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for bowtie and bowtie-build to use
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Print the output to this path. It will be in SAM format unless the path
      ends in ".bam". If not given, it will be printed to stdout in SAM format.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
