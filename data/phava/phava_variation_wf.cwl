cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phava
  - variation_wf
label: phava_variation_wf
doc: "Combine locate, create, and ratio steps into one workflow for identifying phase variation\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: dir_name
    type: string
    doc: "Name of the work directory where data and output are stored (use the same one for all PhaVa operations); created when it does not exist yet"
    inputBinding:
      position: 1
      prefix: --dir
  - id: prior_dir
    type:
      - 'null'
      - Directory
    doc: "Work directory written by an earlier PhaVa step (staged writable under the name given in dir_name)"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 2
      prefix: --cpus
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Should the logging info be output to stdout? Otherwise it is written to PhaVa.log"
    inputBinding:
      position: 3
      prefix: --log
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Name of input assembly file to be searched"
    inputBinding:
      position: 10
      prefix: --fasta
  - id: flank_size
    type:
      - 'null'
      - int
    doc: "Size flanking size to include on either side of invertable regions (in bps)"
    inputBinding:
      position: 11
      prefix: --flankSize
  - id: genes
    type:
      - 'null'
      - File
    doc: "List of gene features in ncbi genbank format, for detecting gene/inverton overlaps"
    inputBinding:
      position: 12
      prefix: --genes
  - id: genes_format
    type:
      - 'null'
      - string
    doc: "File format of the list of gene features (gff or gbff); gff must be in prodigal gff format"
    inputBinding:
      position: 13
      prefix: --genesFormat
  - id: mock_genome
    type:
      - 'null'
      - boolean
    doc: "Create a mock genome where all putative IRs are flipped to opposite of the reference orientation"
    inputBinding:
      position: 14
      prefix: --mockGenome
  - id: mock_number
    type:
      - 'null'
      - int
    doc: "If creating a mockGenome, the number of invertons to invert; 0 inverts all predicted inverton locations"
    inputBinding:
      position: 15
      prefix: --mockNumber
  - id: fastq
    type:
      - 'null'
      - File
    doc: "Name of the reads file to be used for mapping"
    inputBinding:
      position: 20
      prefix: --fastq
  - id: min_rc
    type:
      - 'null'
      - int
    doc: "The minimum count of mapped reads to an inverted inverton for it to be reported in the output"
    inputBinding:
      position: 21
      prefix: --minRC
  - id: max_mismatch
    type:
      - 'null'
      - float
    doc: "Maximum proportion of inverton sequence that can be mismatch before a read is removed"
    inputBinding:
      position: 22
      prefix: --maxMismatch
  - id: keep_sam
    type:
      - 'null'
      - boolean
    doc: "Keep the sam file from the mapping"
    inputBinding:
      position: 23
      prefix: --keepSam
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: "Report mapping results for all putative invertons, regardless of outcome"
    inputBinding:
      position: 24
      prefix: --reportAll
  - id: short_reads
    type:
      - 'null'
      - boolean
    doc: "Run the pipeline with short reads instead of long reads"
    inputBinding:
      position: 25
      prefix: --short-reads
  - id: fastq2
    type:
      - 'null'
      - File
    doc: "Name of the file with reverse reads to be used for mapping (only for paired short reads)"
    inputBinding:
      position: 26
      prefix: -r2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: work_dir
    type: Directory
    doc: Work directory with the PhaVa data, intermediate files and results
    outputBinding:
      glob: $(inputs.dir_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.dir_name)
        entry: '${ return inputs.prior_dir ? inputs.prior_dir : {"class": "Directory", "basename": inputs.dir_name, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_variation_wf.out
