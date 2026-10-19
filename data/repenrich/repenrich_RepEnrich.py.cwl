cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepEnrich.py
label: repenrich_RepEnrich.py
doc: "Part II: Conducting the alignments to the psuedogenomes. Before doing this
  step you will require 1) a bamfile of the unique alignments with index 2) a fastq
  file of the reads mapping to more than one location. These files can be obtained
  using the following bowtie options [EXAMPLE: bowtie -S -m 1 --max multimap.fastq
  mm9 mate1_reads.fastq] Once you have the unique alignment bamfile and the reads
  mapping to more than one location in a fastq file you can run this step.\n\nTool
  homepage: https://github.com/nskvir/RepEnrich"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outputfolder)
        writable: true
        entry: '$({"class": "Directory", "listing": []})'
inputs:
  - id: annotation_file
    type: File
    doc: List RepeatMasker.org annotation file for your organism. The file may
      be downloaded from the RepeatMasker.org website.
    inputBinding:
      position: 1
  - id: outputfolder
    type: string
    doc: List folder to contain results.
    inputBinding:
      position: 2
  - id: outputprefix
    type: string
    doc: Enter prefix name for data.
    inputBinding:
      position: 3
  - id: setup_folder
    type: Directory
    doc: List folder that contains the repeat element psuedogenomes (made by RepEnrich_setup.py).
    inputBinding:
      position: 4
  - id: fastqfile
    type: File
    doc: Enter file for the fastq reads that map to multiple locations.
    inputBinding:
      position: 5
  - id: alignment_bam
    type: File
    doc: Enter bamfile output for reads that map uniquely.
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 6
  - id: pairedend
    type:
      - 'null'
      - string
    doc: Designate this option for paired-end sequencing. Default FALSE change
      to TRUE
    inputBinding:
      position: 101
      prefix: --pairedend
  - id: collapserepeat
    type:
      - 'null'
      - string
    doc: Designate this option to generate a collapsed repeat type. Uncollapsed
      output is generated in addition to collapsed repeat type. Simple_repeat is
      default to simplify downstream analysis. You can change the default to
      another repeat name to collapse a seperate specific repeat instead or if the
      name of Simple_repeat is different for your organism.
    inputBinding:
      position: 101
      prefix: --collapserepeat
  - id: threshold
    type:
      - 'null'
      - int
    doc: This option specifies overlap between repetitive elements and reads that
      map uniquely to the genome. You should change the option depending on the
      read length. We felt that the the value should be close to half read length.
      Default 21
    inputBinding:
      position: 101
      prefix: --threshold
  - id: tolerance
    type:
      - 'null'
      - int
    doc: This option helps to modifies the scrutiny of the region sorter. Default 500
    inputBinding:
      position: 101
      prefix: --tolerance
  - id: fastqfile2
    type:
      - 'null'
      - File
    doc: Enter fastqfile2 when using paired-end option. Default none
    inputBinding:
      position: 101
      prefix: --fastqfile2
  - id: cpus
    type:
      - 'null'
      - int
    doc: Enter available cpus per node. The more cpus the faster RepEnrich
      performs. Default 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: allcountmethod
    type:
      - 'null'
      - string
    doc: By default the pipeline only outputs the fraction count method. Changing
      this option to TRUE will include the unique count method and the total count
      method. Default FALSE
    inputBinding:
      position: 101
      prefix: --allcountmethod
  - id: is_bed
    type:
      - 'null'
      - string
    doc: Is the annotation file a bed file. Default FALSE change to TRUE
    inputBinding:
      position: 101
      prefix: --is_bed
outputs:
  - id: results
    type: Directory
    doc: Result folder with the repeat counts (<prefix>_fraction_counts.txt, class and family counts)
    outputBinding:
      glob: $(inputs.outputfolder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repenrich:1.2--py27_1
