cwlVersion: v1.2
class: CommandLineTool
baseCommand: DiscovarDeNovo
label: discovardenovo
doc: "DISCOVAR de novo (experimental) is a de novo genome assembler that requires
  only a single PCR-free paired end Illumina library containing 250 base reads.\n\
  \nTool homepage: https://github.com/bayolau/discovardenovo"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: Comma-separated list of input files, see manual for details
    inputBinding:
      position: 101
      prefix: READS=
      separate: false
      itemSeparator: ','
  - id: out_dir
    type: string
    doc: name of output directory
    inputBinding:
      position: 101
      prefix: OUT_DIR=
      separate: false
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads. By default, the number of processors online.
    inputBinding:
      position: 101
      prefix: NUM_THREADS=
      separate: false
  - id: refhead
    type:
      - 'null'
      - File
    doc: use reference sequence REFHEAD.fasta to annotate assembly, and also
      REFHEAD.names if it exists (give the .fasta file)
    secondaryFiles:
      - pattern: ^.names
        required: false
    inputBinding:
      position: 101
      prefix: REFHEAD=
      separate: false
      valueFrom: $(self.dirname + '/' + self.nameroot)
  - id: max_mem_gb
    type:
      - 'null'
      - float
    doc: if specified, maximum allowed RAM use in GB; in some cases may be
      exceeded by our code
    inputBinding:
      position: 101
      prefix: MAX_MEM_GB=
      separate: false
  - id: memory_check
    type:
      - 'null'
      - boolean
    doc: if True, attempt to determine actual available memory and cap memory
      usage accordingly; slow and can cause machine to become very sluggish,
      or can result in process being killed
    inputBinding:
      position: 101
      valueFrom: "$(self ? 'MEMORY_CHECK=True' : 'MEMORY_CHECK=False')"
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Whether to suppress the normal command-line header block.
    inputBinding:
      position: 101
      valueFrom: "$(self ? 'NO_HEADER=True' : 'NO_HEADER=False')"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (run log and assembly statistics)
  - id: out_dir_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
  - id: assembly_fasta
    type: File
    doc: Final assembly lines in FASTA format (a.final/a.lines.fasta)
    outputBinding:
      glob: $(inputs.out_dir)/a.final/a.lines.fasta
  - id: assembly_efasta
    type:
      - 'null'
      - File
    doc: Final assembly lines in efasta format (a.final/a.lines.efasta)
    outputBinding:
      glob: $(inputs.out_dir)/a.final/a.lines.efasta
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discovardenovo:52488--1
stdout: discovardenovo.out
