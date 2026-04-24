cwlVersion: v1.2
class: CommandLineTool
baseCommand: hairsplitter.py
label: hairsplitter_hairsplitter.py
doc: "Welcome!\n\nTool homepage: https://github.com/RolandFaure/HairSplitter"
inputs:
  - id: assembly
    type: File
    doc: Original assembly in GFA or FASTA format (required)
    inputBinding:
      position: 101
      prefix: --assembly
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Clean the temporary files
    inputBinding:
      position: 101
      prefix: --clean
  - id: correct_assembly
    type:
      - 'null'
      - boolean
    doc: Correct structural errors in the input assembly (time-consuming)
    inputBinding:
      position: 101
      prefix: --correct-assembly
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: dont_simplify
    type:
      - 'null'
      - boolean
    doc: Don't merge the contig
    inputBinding:
      position: 101
      prefix: --dont_simplify
  - id: fastq
    type: File
    doc: Sequencing reads fastq or fasta (required)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of output folder if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: haploid_coverage
    type:
      - 'null'
      - int
    doc: Expected haploid coverage. 0 if does not apply
    inputBinding:
      position: 101
      prefix: --haploid-coverage
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Turn on the low-memory mode (at the expense of speed)
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: minimap2_params
    type:
      - 'null'
      - string
    doc: Parameters to pass to minimap2
    inputBinding:
      position: 101
      prefix: --minimap2-params
  - id: output
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: path_to_medaka
    type:
      - 'null'
      - File
    doc: Path to the executable medaka
    inputBinding:
      position: 101
      prefix: --path_to_medaka
  - id: path_to_minigraph
    type:
      - 'null'
      - File
    doc: Path to the executable minigraph
    inputBinding:
      position: 101
      prefix: --path_to_minigraph
  - id: path_to_minimap2
    type:
      - 'null'
      - File
    doc: Path to the executable minimap2
    inputBinding:
      position: 101
      prefix: --path_to_minimap2
  - id: path_to_python
    type:
      - 'null'
      - File
    doc: Path to python
    inputBinding:
      position: 101
      prefix: --path_to_python
  - id: path_to_racon
    type:
      - 'null'
      - File
    doc: Path to the executable racon
    inputBinding:
      position: 101
      prefix: --path_to_racon
  - id: path_to_raven
    type:
      - 'null'
      - File
    doc: Path to raven
    inputBinding:
      position: 101
      prefix: --path_to_raven
  - id: path_to_samtools
    type:
      - 'null'
      - File
    doc: Path to samtools
    inputBinding:
      position: 101
      prefix: --path_to_samtools
  - id: polish_everything
    type:
      - 'null'
      - boolean
    doc: Polish every contig with racon, even those where there is only one 
      haplotype
    inputBinding:
      position: 101
      prefix: --polish-everything
  - id: polisher
    type:
      - 'null'
      - string
    doc: '{racon,medaka} medaka is more accurate but much slower'
    inputBinding:
      position: 101
      prefix: --polisher
  - id: rarest_strain_abundance
    type:
      - 'null'
      - float
    doc: Limit on the relative abundance of the rarest strain to detect (0 might
      be slow for some datasets)
    inputBinding:
      position: 101
      prefix: --rarest-strain-abundance
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume from a previous run
    inputBinding:
      position: 101
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_case
    type:
      - 'null'
      - string
    doc: '{ont, pacbio, hifi,amplicon}'
    inputBinding:
      position: 101
      prefix: --use-case
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hairsplitter:1.9.10--h8b7377a_1
stdout: hairsplitter_hairsplitter.py.out
