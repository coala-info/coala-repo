cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicstuff
  - missview
label: hicstuff_missview
doc: 'Previews bins that will be missing in a Hi-C map with a given read length by
  finding repetitive regions in the genome.


  Tool homepage: https://github.com/koszullab/hicstuff'
inputs:
  - id: genome
    type: File
    doc: Genome file in fasta format. For the default aligner bowtie2 its index must
      have the FASTA path as prefix (seq.fa.1.bt2, seq.fa.2.bt2, ..., made with bowtie2-build
      seq.fa seq.fa); bwa index files (seq.fa.amb, ...) work the same way; minimap2
      needs only the FASTA.
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .1.bt2
        required: false
      - pattern: .2.bt2
        required: false
      - pattern: .3.bt2
        required: false
      - pattern: .4.bt2
        required: false
      - pattern: .rev.1.bt2
        required: false
      - pattern: .rev.2.bt2
        required: false
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
  - id: output_image
    type: string
    doc: Path to the output image.
    inputBinding:
      position: 2
  - id: aligner
    type:
      - 'null'
      - string
    doc: The read alignment software to use. Can be either bowtie2, minimap2 or bwa.
      minimap2 should only be used for reads > 100 bp.
    inputBinding:
      position: 102
      prefix: --aligner
  - id: binning
    type:
      - 'null'
      - int
    doc: Resolution to use to preview the Hi-C map.
    inputBinding:
      position: 102
      prefix: --binning
  - id: force
    type:
      - 'null'
      - boolean
    doc: Write even if the output file already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: read_len
    type: int
    doc: Read length used to preview the missing bins.
    inputBinding:
      position: 102
      prefix: --read-len
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use in parallel.
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Directory where temporary files will be generated.
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: output
    type: File
    doc: Image of the Hi-C map with the bins that will be missing.
    outputBinding:
      glob: $(inputs.output_image)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
