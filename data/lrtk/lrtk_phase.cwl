cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - PHASE
label: lrtk_phase
doc: "Phase germline variants from linked-read alignments with HapCUT2 or WhatsHap.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bam
    type: File
    doc: The alignment file (.bam), indexed.
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 1
      prefix: -B
  - id: vcf
    type: File
    doc: The detected variants to phase
    inputBinding:
      position: 1
      prefix: -V
  - id: reference
    type: File
    doc: The indexed reference genome FASTA file.
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 1
      prefix: -R
  - id: application
    type:
      - 'null'
      - string
    doc: The variant phasing tool. Users can choose from (HapCUT2, WhatsHap).
    inputBinding:
      position: 1
      prefix: -A
  - id: number
    type:
      - 'null'
      - int
    doc: The number of strains for each species, required for metagenome phasing.
    inputBinding:
      position: 1
      prefix: -N
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, this determines the number of threads used for phasing tools.
    inputBinding:
      position: 1
      prefix: -T
  - id: outfile
    type: string
    doc: The final phased VCF file to write.
    inputBinding:
      position: 1
      prefix: -O
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome pattern to process (human or metagenome).
    inputBinding:
      position: 1
      prefix: -G
outputs:
  - id: phased_output
    type: File
    doc: The output file (-O); HapCUT2 writes its haplotype blocks here, 
      WhatsHap writes the phased VCF here.
    outputBinding:
      glob: $(inputs.outfile)
  - id: hapcut2_phased_vcf
    type:
      - 'null'
      - File
    doc: Phased VCF written by HapCUT2 (<outfile>.phased.VCF).
    outputBinding:
      glob: $(inputs.outfile).phased.VCF
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
