cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - fusion
label: flair_fusion
doc: "FLAIR fusion detection module for identifying gene fusions from transcriptomic
  data.\n\nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: genome
    type: File
    doc: FastA of reference genome
    inputBinding:
      position: 101
      prefix: --genome
  - id: genome_chimbam
    type: File
    doc: bam file of chimeric reads from genomic alignment from flair align
    inputBinding:
      position: 101
      prefix: --genomechimbam
  - id: gtf
    type: File
    doc: GTF annotation file, used for renaming FLAIR isoforms to annotated isoforms
      and adjusting TSS/TESs
    inputBinding:
      position: 101
      prefix: --gtf
  - id: max_loci
    type:
      - 'null'
      - int
    doc: max loci detected in fusion. Set higher for detection of 3-gene+ fusions
    inputBinding:
      position: 101
      prefix: --maxloci
  - id: min_fragment_size
    type:
      - 'null'
      - int
    doc: minimum size of alignment kept, used in minimap -s. More important when doing
      downstream fusion detection
    inputBinding:
      position: 101
      prefix: --minfragmentsize
  - id: reads
    type:
      type: array
      items: File
    doc: FastA/FastQ files of raw reads, can specify multiple files
    inputBinding:
      position: 101
      prefix: --reads
  - id: support
    type:
      - 'null'
      - int
    doc: minimum number of supporting reads for a fusion
    inputBinding:
      position: 101
      prefix: --support
  - id: threads
    type:
      - 'null'
      - int
    doc: minimap2 number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: transcript_chimbam
    type:
      - 'null'
      - File
    doc: 'Optional: bam file of chimeric reads from transcriptomic alignment. If not
      provided, this will be made for you'
    inputBinding:
      position: 101
      prefix: --transcriptchimbam
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name base for FLAIR isoforms
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
