cwlVersion: v1.2
class: CommandLineTool
baseCommand: nudup.py
label: nudup_nudup.py
doc: "Marks/removes PCR introduced duplicate molecules based on the molecular tagging
  technology used in NuGEN products.\n\nTool homepage: http://nugentechnologies.github.io/nudup/"
inputs:
  - id: input_sam_bam
    type: File
    doc: input sorted/unsorted SAM/BAM containing only unique alignments (sorted
      required for case 2 detailed above)
    inputBinding:
      position: 1
  - id: fastq_file
    type:
      - 'null'
      - File
    doc: FASTQ file containing the molecular tag sequence for each read name in 
      the corresponding SAM/BAM file (required only for CASE 1 detailed above)
    inputBinding:
      position: 102
      prefix: -f
  - id: length
    type:
      - 'null'
      - int
    doc: length of molecular tag sequence
    default: 6
    inputBinding:
      position: 102
      prefix: --length
  - id: old_samtools
    type:
      - 'null'
      - boolean
    doc: required for compatibility with samtools sort style in samtools 
      versions <=0.1.19
    inputBinding:
      position: 102
      prefix: --old-samtools
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: prefix of output file paths for sorted BAMs (default will create 
      prefix.sorted.markdup.bam, prefix.sorted.dedup.bam, prefix_dup_log.txt)
    inputBinding:
      position: 102
      prefix: --out
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: use paired end deduping with template. SAM/BAM alignment must contain 
      paired end reads. Degenerate read pairs (alignments for one read of pair) 
      will be discarded.
    inputBinding:
      position: 102
      prefix: --paired-end
  - id: rmdup_only
    type:
      - 'null'
      - boolean
    doc: required for only outputting duplicates removed file
    inputBinding:
      position: 102
      prefix: --rmdup-only
  - id: start
    type:
      - 'null'
      - int
    doc: position in index read where molecular tag sequence begins. This should
      be a 1-based value that counts in from the 3' END of the read.
    default: 6
    inputBinding:
      position: 102
      prefix: --start
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: directory for reading and writing to temporary files and named pipes
    default: /tmp
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nudup:2.3.3--py27_0
stdout: nudup_nudup.py.out
