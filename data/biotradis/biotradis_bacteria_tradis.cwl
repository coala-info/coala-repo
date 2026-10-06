cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacteria_tradis
label: biotradis_bacteria_tradis
doc: "Run a TraDIS analysis. This involves filtering data with tags, removing tags,
  mapping, creating an insertion site plot, and creating a stats summary.\n\nTool
  homepage: https://github.com/sanger-pathogens/Bio-Tradis"
inputs:
  - id: essentiality_defaults
    type:
      - 'null'
      - boolean
    doc: set defaults for essentiality experiment (smalt_r = 0, -m = 0)
    inputBinding:
      position: 101
      prefix: -e
  - id: fastq_list_file
    type: File
    doc: text file listing fastq files with tradis tags attached
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
  - id: fastq_files
    type:
      type: array
      items: File
    doc: The fastq files named in the fastq list file; they are staged in the 
      working directory next to the list file so the names in the list resolve.
  - id: kmer_value
    type:
      - 'null'
      - int
    doc: custom k-mer value (min seed length)
    inputBinding:
      position: 101
      prefix: -k
  - id: mapping_quality_cutoff
    type:
      - 'null'
      - int
    doc: mapping quality cutoff score
    inputBinding:
      position: 101
      prefix: -m
  - id: mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches allowed when matching tag
    inputBinding:
      position: 101
      prefix: -mm
  - id: reference_genome
    type: File
    doc: reference genome in fasta format (.fa); staged writable because the 
      mapper index is written next to it
    inputBinding:
      position: 101
      prefix: -r
      valueFrom: $(self.basename)
  - id: smalt_kmer
    type:
      - 'null'
      - int
    doc: custom k-mer value for SMALT mapping
    inputBinding:
      position: 101
      prefix: --smalt_k
  - id: smalt_r_parameter
    type:
      - 'null'
      - int
    doc: custom r parameter for SMALT
    inputBinding:
      position: 101
      prefix: --smalt_r
  - id: smalt_step_size
    type:
      - 'null'
      - int
    doc: custom step size for SMALT mapping
    inputBinding:
      position: 101
      prefix: --smalt_s
  - id: smalt_y_parameter
    type:
      - 'null'
      - float
    doc: custom y parameter for SMALT
    inputBinding:
      position: 101
      prefix: --smalt_y
  - id: tag
    type:
      - 'null'
      - string
    doc: tag to search for (optional. If not set runs bwa in tagless mode with no
      filtering.)
    inputBinding:
      position: 101
      prefix: -t
  - id: tag_direction
    type:
      - 'null'
      - int
    doc: tag direction - 3 or 5
    inputBinding:
      position: 101
      prefix: -td
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for SMALT and samtools sort
    inputBinding:
      position: 101
      prefix: -n
  - id: use_smalt
    type:
      - 'null'
      - boolean
    doc: use smalt rather than bwa as the mapper
    inputBinding:
      position: 101
      prefix: --smalt
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose debugging output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: insert_site_plots
    type:
      type: array
      items: File
    doc: Insertion site plots for Artemis, one per fastq file and reference 
      sequence
    outputBinding:
      glob: '*.insert_site_plot.gz'
  - id: mapped_bams
    type:
      type: array
      items: File
    doc: Sorted mapped BAM files with their index
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: '*.mapped.bam'
  - id: bamcheck_files
    type:
      type: array
      items: File
    doc: samtools stats output for each mapped BAM
    outputBinding:
      glob: '*.mapped.bamcheck'
  - id: stats
    type:
      - 'null'
      - File
    doc: Stats summary of the run
    outputBinding:
      glob: '*.stats'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${ return inputs.fastq_files.concat([inputs.fastq_list_file,
             {"entry": inputs.reference_genome, "writable": true}]); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
stdout: biotradis_bacteria_tradis.out
