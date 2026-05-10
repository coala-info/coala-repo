cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotatePeaks.pl
label: homer_annotatePeaks.pl
doc: "Annotates peaks with genomic information such as proximity to TSS, gene annotations,
  and can perform motif discovery or integrate sequencing data.\n\nTool homepage:
  http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: peak_file
    type: File
    doc: Input peak/BED file to be annotated
    inputBinding:
      position: 1
  - id: genome
    type: string
    doc: Genome version (e.g., hg38, mm10) or path to genome FASTA file
    inputBinding:
      position: 2
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 103
      prefix: -cpu
  - id: motif_file
    type:
      - 'null'
      - type: array
        items: File
    doc: List of motif files to search for
    inputBinding:
      position: 103
      prefix: -m
  - id: size
    type:
      - 'null'
      - string
    doc: The size of the region for motif finding or counting, default is 
      'given'
    inputBinding:
      position: 103
      prefix: -size
  - id: tag_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: List of tag directories to use for coverage/counting
    inputBinding:
      position: 103
      prefix: -d
  - id: annotation_stats_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `annotation_stats_path`
    inputBinding:
      position: 104
      prefix: --annotation-stats
  - id: go_directory_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `go_directory_path`
    inputBinding:
      position: 105
      prefix: --go-directory
outputs:
  - id: annotation_stats
    type:
      - 'null'
      - File
    doc: File to write annotation statistics
    outputBinding:
      glob: $(inputs.annotation_stats_path)
  - id: go_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write Gene Ontology analysis results
    outputBinding:
      glob: $(inputs.go_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
