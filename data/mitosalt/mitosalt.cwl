cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/bin/MitoSAlt1.1.1.pl
label: mitosalt
doc: "MitoSAlt detects mitochondrial DNA deletions and duplications (breakpoints,
  clusters, heteroplasmy levels) and estimates mtDNA copy number from paired-end
  whole-genome or mtDNA-enriched sequencing reads. It runs HISAT2 on the nuclear and
  mitochondrial genome, then LAST on the mitochondrial reads. This wrapper calls the
  script behind the 'mitosalt' command directly so that a genome database directory
  (made with download-mitosalt-db.sh) can be given; the 'mitosalt' launcher script
  would force the empty database inside the image.\n\nUsage: mitosalt <config_file>
  <fastq file 1> <fastq file 2> <study name>\n\nTool homepage: https://sourceforge.net/projects/mitosalt/"
inputs:
  - id: config_file
    type: File
    doc: Configuration file (see config_human.txt or config_mouse.txt in the MitoSAlt
      share directory). Its database entries are resolved inside the database directory.
    inputBinding:
      position: 1
  - id: fastq_file_1
    type: File
    doc: FASTQ file 1
    inputBinding:
      position: 2
  - id: fastq_file_2
    type: File
    doc: FASTQ file 2
    inputBinding:
      position: 3
  - id: study_name
    type: string
    doc: Study name, used as the prefix of the output files
    inputBinding:
      position: 4
  - id: database
    type: Directory
    doc: MitoSAlt database directory (the MITOSALT_DATA folder holding genome/ with
      the HISAT2 index, the genome FASTA and its .fai, hg.size, the mitochondrial
      FASTA and its LAST index).
outputs:
  - id: indel
    type:
      - 'null'
      - Directory
    doc: Deletion and duplication breakpoints and clusters ("<study>.breakpoint",
      "<study>.cluster").
    outputBinding:
      glob: indel
  - id: tab
    type:
      - 'null'
      - Directory
    doc: Tables of the alignments and copy number.
    outputBinding:
      glob: tab
  - id: bam
    type:
      - 'null'
      - Directory
    doc: Alignment files.
    outputBinding:
      glob: bam
  - id: bw
    type:
      - 'null'
      - Directory
    doc: Coverage tracks.
    outputBinding:
      glob: bw
  - id: plot
    type:
      - 'null'
      - Directory
    doc: Plots.
    outputBinding:
      glob: plot
  - id: log
    type:
      - 'null'
      - Directory
    doc: Run log.
    outputBinding:
      glob: log
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MITOSALT_DATA
        envValue: $(inputs.database.path)
      - envName: CONDA_ENV_BIN
        envValue: /usr/local/bin
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_3
