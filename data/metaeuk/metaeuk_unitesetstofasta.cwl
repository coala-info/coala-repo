cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaeuk_unitesetstofasta
label: metaeuk_unitesetstofasta
doc: "By Eli Levy Karin <eli.levy.karin@gmail.com>\n\nTool homepage: https://github.com/soedinglab/metaeuk"
inputs:
  - id: contigs_db
    type: File
    doc: contigsDB
    inputBinding:
      position: 1
  - id: targets_db
    type: File
    doc: targetsDB
    inputBinding:
      position: 2
  - id: exons_db
    type: File
    doc: exonsDB
    inputBinding:
      position: 3
  - id: len_scan_for_start
    type:
      - 'null'
      - int
    doc: length to scan for a start codon before the first exon and in the same 
      frame. By default (0) no scan [0]
    inputBinding:
      position: 104
      prefix: --len-scan-for-start
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: protein
    type:
      - 'null'
      - int
    doc: translate the joint exons coding sequence to amino acids [0,1]
    inputBinding:
      position: 104
      prefix: --protein
  - id: target_key
    type:
      - 'null'
      - int
    doc: write the target key (internal DB identifier) instead of its accession.
      By default (0) target accession will be written [0,1]
    inputBinding:
      position: 104
      prefix: --target-key
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL,
      5) INVERT_MITOCHONDRIAL, 6) CILIATE\n                            9) FLATWORM_MITOCHONDRIAL,
      10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14)
      ALT_FLATWORM_MITOCHONDRIAL\n                            15) BLEPHARISMA, 16)
      CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL\n\
      \                            23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL,
      25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA\n   \
      \                          29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA"
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: write_frag_coords
    type:
      - 'null'
      - int
    doc: write the contig coords of the stop-to-stop fragment in which putative 
      exon lies. By default (0) only putative exon coords will be written [0,1]
    inputBinding:
      position: 104
      prefix: --write-frag-coords
outputs:
  - id: united_exons_fasta
    type: File
    doc: unitedExonsFasta
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
