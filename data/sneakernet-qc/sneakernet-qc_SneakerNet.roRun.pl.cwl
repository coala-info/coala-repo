cwlVersion: v1.2
class: CommandLineTool
baseCommand: SneakerNet.roRun.pl
label: sneakernet-qc_SneakerNet.roRun.pl
doc: "Parses an unaltered Illumina run and formats it into something usable for SneakerNet.
  Fastq files must be in the format of _R1_ and _R2_ instead of _1 and _2 for this
  particular script.\n\nTool homepage: https://github.com/lskatz/sneakernet"
inputs:
  - id: illumina_directory
    type:
      type: array
      items: Directory
    doc: Path to an Illumina run directory
    inputBinding:
      position: 1
  - id: createsamplesheet
    type:
      - 'null'
      - boolean
    doc: Also create a SampleSheet.csv or samples.tsv as fallback
    inputBinding:
      position: 102
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 102
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
stdout: sneakernet-qc_SneakerNet.roRun.pl.out
