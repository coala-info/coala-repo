cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava variation_wf
label: phava_variation_wf
doc: "PhaVa variation workflow\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: directory
    type: Directory
    doc: Directory where data and output are stored *** USE THE SAME WORK 
      DIRECTORY FOR ALL PHAVA OPERATIONS ***
    inputBinding:
      position: 101
      prefix: --dir
  - id: fasta
    type:
      - 'null'
      - File
    doc: Name of input assembly file to be searched
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - File
    doc: Name of the reads file to be used for mapping
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Name of the file with reverse reads to be used for mapping (only for 
      paired short reads!)
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: flank_size
    type:
      - 'null'
      - int
    doc: Size flanking size to include on either side of invertable regions (in 
      bps)
    inputBinding:
      position: 101
      prefix: --flankSize
  - id: genes
    type:
      - 'null'
      - string
    doc: List of gene features in ncbi genbank format, for detecting 
      gene/inverton overlaps
    inputBinding:
      position: 101
      prefix: --genes
  - id: genes_format
    type:
      - 'null'
      - string
    doc: File format of the list of gene features. Gff must be in prodigal gff 
      format
    inputBinding:
      position: 101
      prefix: --genesFormat
  - id: keep_sam
    type:
      - 'null'
      - boolean
    doc: Keep the sam file from the mapping
    inputBinding:
      position: 101
      prefix: --keepSam
  - id: log
    type:
      - 'null'
      - boolean
    doc: Should the logging info be output to stdout? Otherwise, it will be 
      written to 'PhaVa.log'
    inputBinding:
      position: 101
      prefix: --log
  - id: max_mismatch
    type:
      - 'null'
      - float
    doc: Maximum proportion of inverton sequence that can be mismatch before a 
      read is removed
    inputBinding:
      position: 101
      prefix: --maxMismatch
  - id: min_rc
    type:
      - 'null'
      - int
    doc: The minimum count of mapped reads to an 'inverted' inverton for it to 
      be reported in the output
    inputBinding:
      position: 101
      prefix: --minRC
  - id: mock_genome
    type:
      - 'null'
      - boolean
    doc: Create a mock genome where all putative IRs are flipped to opposite of 
      the reference orientation
    inputBinding:
      position: 101
      prefix: --mockGenome
  - id: mock_number
    type:
      - 'null'
      - int
    doc: If creating a mockGenome, the number of invertons to invert. A value of
      0 inverts all predicted inverton locations
    inputBinding:
      position: 101
      prefix: --mockNumber
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: Report mapping results for all putative invertons, regardless of 
      outcome
    inputBinding:
      position: 101
      prefix: --reportAll
  - id: short_reads
    type:
      - 'null'
      - boolean
    doc: Run the pipeline with short reads instead of long reads
    inputBinding:
      position: 101
      prefix: --short-reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_variation_wf.out
