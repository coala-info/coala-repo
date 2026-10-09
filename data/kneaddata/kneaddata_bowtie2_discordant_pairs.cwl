cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kneaddata_bowtie2_discordant_pairs
label: kneaddata_bowtie2_discordant_pairs
doc: "Kneaddata bowtie2 discordant pairs\n\nTool homepage: https://huttenhower.sph.harvard.edu/kneaddata"
inputs:
  - id: pair1
    type: File
    doc: the fastq file of pair1 reads
    inputBinding:
      position: 101
      prefix: '-1'
  - id: pair2
    type: File
    doc: the fastq file of pair2 reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: index
    type: File
    doc: the database index file (the .1.bt2 file; the other index files are staged with it)
    secondaryFiles:
      - ^^.2.bt2
      - ^^.3.bt2
      - ^^.4.bt2
      - ^^.rev.1.bt2
      - ^^.rev.2.bt2
    inputBinding:
      position: 101
      prefix: '-x'
      valueFrom: $(self.path.replace(/\.1\.bt2$/, ""))
  - id: un_pair
    type: string
    doc: the name of the output files for the paired reads without any alignments (use % for the pair number, for example un_pair_%.fastq)
    inputBinding:
      position: 101
      prefix: --un-pair
  - id: al_pair
    type: string
    doc: the name of the output files for the paired reads with concordant alignments (use % for the pair number)
    inputBinding:
      position: 101
      prefix: --al-pair
  - id: un_single
    type: string
    doc: the name of the output files for the orphan reads without alignments (use % for the pair number)
    inputBinding:
      position: 101
      prefix: --un-single
  - id: al_single
    type: string
    doc: the name of the output files for the orphan reads with alignments (use % for the pair number)
    inputBinding:
      position: 101
      prefix: --al-single
  - id: orphan
    type:
      - 'null'
      - type: array
        items: File
    doc: the fastq files of orphan reads in comma-delimited list
    inputBinding:
      position: 101
      prefix: -U
      itemSeparator: ','
  - id: sam
    type:
      - 'null'
      - string
    doc: the file to write the sam output
    inputBinding:
      position: 101
      prefix: -S
  - id: bowtie2
    type:
      - 'null'
      - string
    doc: the path to the bowtie2 executable
    inputBinding:
      position: 101
      prefix: --bowtie2
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: bowtie2_options
    type:
      - 'null'
      - string
    doc: the bowtie2 options to apply
    inputBinding:
      position: 101
      prefix: --bowtie2-options
  - id: mode
    type:
      - 'null'
      - string
    doc: the run mode (strict or unpaired)
    inputBinding:
      position: 101
      prefix: --mode
  - id: cat_pairs
    type:
      - 'null'
      - boolean
    doc: concatenate pair files before aligning so reads are aligned as single end
    inputBinding:
      position: 101
      prefix: --cat-pairs
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: print the sequences in the same order as the input files
    inputBinding:
      position: 101
      prefix: --reorder
outputs:
  - id: stdout
    type: stdout
    doc: Read counts per output file
  - id: unaligned_pairs
    type:
      type: array
      items: File
    doc: paired reads without alignments
    outputBinding:
      glob: $(inputs.un_pair.replace("%", "*"))
  - id: aligned_pairs
    type:
      type: array
      items: File
    doc: paired reads with alignments
    outputBinding:
      glob: $(inputs.al_pair.replace("%", "*"))
  - id: unaligned_orphans
    type:
      type: array
      items: File
    doc: orphan reads without alignments
    outputBinding:
      glob: $(inputs.un_single.replace("%", "*"))
  - id: aligned_orphans
    type:
      type: array
      items: File
    doc: orphan reads with alignments
    outputBinding:
      glob: $(inputs.al_single.replace("%", "*"))
  - id: sam_output
    type:
      - 'null'
      - File
    doc: bowtie2 alignments in SAM format
    outputBinding:
      glob: $(inputs.sam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kneaddata:0.12.4--pyhdfd78af_0
stdout: kneaddata_bowtie2_discordant_pairs.out
