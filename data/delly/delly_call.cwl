cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - delly
  - call
label: delly_call
doc: "Compute structural variants\n\nTool homepage: https://github.com/dellytools/delly"
inputs:
  - id: sample1_sort_bam
    type: File
    doc: sample1.sort.bam
    inputBinding:
      position: 1
  - id: sample2_sort_bam
    type: File
    doc: sample2.sort.bam
    inputBinding:
      position: 2
  - id: additional_samples
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional sample BAM files
    inputBinding:
      position: 3
  - id: exclude_regions_file
    type:
      - 'null'
      - File
    doc: file with regions to exclude
    inputBinding:
      position: 104
      prefix: --exclude
  - id: genome_fasta_file
    type: File
    doc: genome fasta file
    inputBinding:
      position: 104
      prefix: --genome
  - id: input_vcf_bcf_file
    type:
      - 'null'
      - File
    doc: input VCF/BCF file for genotyping
    inputBinding:
      position: 104
      prefix: --vcffile
  - id: mad_cutoff_insert_size
    type:
      - 'null'
      - int
    doc: insert size cutoff, median+s*MAD (deletions only)
    default: 9
    inputBinding:
      position: 104
      prefix: --mad-cutoff
  - id: max_genotyping_reads_sr
    type:
      - 'null'
      - int
    doc: max. number of reads aligned for SR genotyping
    default: 250
    inputBinding:
      position: 104
      prefix: --max-geno-count
  - id: max_read_separation
    type:
      - 'null'
      - int
    doc: max. read separation
    default: 40
    inputBinding:
      position: 104
      prefix: --maxreadsep
  - id: max_reads_consensus
    type:
      - 'null'
      - int
    doc: max. reads for consensus computation
    default: 20
    inputBinding:
      position: 104
      prefix: --max-reads
  - id: min_clipping_length
    type:
      - 'null'
      - int
    doc: min. clipping length
    default: 25
    inputBinding:
      position: 104
      prefix: --minclip
  - id: min_clique_size
    type:
      - 'null'
      - int
    doc: min. PE/SR clique size
    default: 2
    inputBinding:
      position: 104
      prefix: --min-clique-size
  - id: min_genotyping_mapping_quality
    type:
      - 'null'
      - int
    doc: min. mapping quality for genotyping
    default: 5
    inputBinding:
      position: 104
      prefix: --geno-qual
  - id: min_paired_end_mapping_quality
    type:
      - 'null'
      - int
    doc: min. paired-end (PE) mapping quality
    default: 1
    inputBinding:
      position: 104
      prefix: --map-qual
  - id: min_quality_translocation
    type:
      - 'null'
      - int
    doc: min. PE quality for translocation
    default: 20
    inputBinding:
      position: 104
      prefix: --qual-tra
  - id: min_reference_separation
    type:
      - 'null'
      - int
    doc: min. reference separation
    default: 25
    inputBinding:
      position: 104
      prefix: --minrefsep
  - id: svtype
    type:
      - 'null'
      - string
    doc: SV type to compute [DEL, INS, DUP, INV, BND, ALL]
    default: ALL
    inputBinding:
      position: 104
      prefix: --svtype
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 4
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: BCF output file
    outputBinding:
      glob: $(inputs.outfile)
  - id: dump_sv_reads_file
    type:
      - 'null'
      - File
    doc: gzipped output file for SV-reads (optional)
    outputBinding:
      glob: $(inputs.dump_sv_reads_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delly:1.7.2--h4d20210_0
