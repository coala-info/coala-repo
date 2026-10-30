cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - splitbam
label: seismic-rna_seismic_splitbam
doc: 'Split a BAM file into one file for each reference.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: fasta
    type: File
    doc: FASTA file of reference sequences
    inputBinding:
      position: 200
  - id: input_path
    type:
      type: array
      items: File
    doc: Input files to process
    inputBinding:
      position: 201
  - id: phred_enc
    type:
      - 'null'
      - int
    doc: 'Specify the Phred score encoding of FASTQ and SAM/BAM/CRAM files [default:
      33]'
    inputBinding:
      position: 100
      prefix: --phred-enc
  - id: out_dir
    type: string
    default: out
    doc: 'Write all output files to this directory [default: ./out]'
    inputBinding:
      position: 100
      prefix: --out-dir
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --keep-tmp
  - id: erase_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --erase-tmp
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Create a new branch of the workflow with this name [default: ""]'
    inputBinding:
      position: 100
      prefix: --branch
  - id: bt2_local
    type:
      - 'null'
      - boolean
    doc: 'Align reads in local mode rather than end- to-end mode [default: bt2-local]'
    inputBinding:
      position: 100
      prefix: --bt2-local
  - id: bt2_end_to_end
    type:
      - 'null'
      - boolean
    doc: 'Align reads in local mode rather than end- to-end mode [default: bt2-local]'
    inputBinding:
      position: 100
      prefix: --bt2-end-to-end
  - id: bt2_discordant
    type:
      - 'null'
      - boolean
    doc: ' Output paired-end reads whose mates align discordantly [default: bt2-no-discordant]'
    inputBinding:
      position: 100
      prefix: --bt2-discordant
  - id: bt2_no_discordant
    type:
      - 'null'
      - boolean
    doc: ' Output paired-end reads whose mates align discordantly [default: bt2-no-discordant]'
    inputBinding:
      position: 100
      prefix: --bt2-no-discordant
  - id: bt2_mixed
    type:
      - 'null'
      - boolean
    doc: 'Attempt to align individual mates of pairs that fail to align [default:
      bt2-no-mixed]'
    inputBinding:
      position: 100
      prefix: --bt2-mixed
  - id: bt2_no_mixed
    type:
      - 'null'
      - boolean
    doc: 'Attempt to align individual mates of pairs that fail to align [default:
      bt2-no-mixed]'
    inputBinding:
      position: 100
      prefix: --bt2-no-mixed
  - id: bt2_dovetail
    type:
      - 'null'
      - boolean
    doc: ' Consider dovetailed mate pairs to align concordantly [default: bt2-no-dovetail]'
    inputBinding:
      position: 100
      prefix: --bt2-dovetail
  - id: bt2_no_dovetail
    type:
      - 'null'
      - boolean
    doc: ' Consider dovetailed mate pairs to align concordantly [default: bt2-no-dovetail]'
    inputBinding:
      position: 100
      prefix: --bt2-no-dovetail
  - id: bt2_contain
    type:
      - 'null'
      - boolean
    doc: ' Consider nested mate pairs to align concordantly [default: bt2-contain]'
    inputBinding:
      position: 100
      prefix: --bt2-contain
  - id: bt2_no_contain
    type:
      - 'null'
      - boolean
    doc: ' Consider nested mate pairs to align concordantly [default: bt2-contain]'
    inputBinding:
      position: 100
      prefix: --bt2-no-contain
  - id: bt2_I
    type:
      - 'null'
      - int
    doc: 'Discard paired-end alignments shorter than this many bases [default: 0]'
    inputBinding:
      position: 100
      prefix: --bt2-I
  - id: bt2_X
    type:
      - 'null'
      - int
    doc: 'Discard paired-end alignments longer than this many bases [default: 600]'
    inputBinding:
      position: 100
      prefix: --bt2-X
  - id: bt2_score_min_loc
    type:
      - 'null'
      - string
    doc: 'Discard alignments that score below this threshold in local mode [default:
      L,1,0.8]'
    inputBinding:
      position: 100
      prefix: --bt2-score-min-loc
  - id: bt2_score_min_e2e
    type:
      - 'null'
      - string
    doc: 'Discard alignments that score below this threshold in end-to-end mode [default:
      L,-1,-0.8]'
    inputBinding:
      position: 100
      prefix: --bt2-score-min-e2e
  - id: bt2_i
    type:
      - 'null'
      - string
    doc: 'Seed Bowtie2 alignments at this interval [default: L,1,0.1]'
    inputBinding:
      position: 100
      prefix: --bt2-i
  - id: bt2_L
    type:
      - 'null'
      - int
    doc: 'Use this seed length for Bowtie2 [default: 20]'
    inputBinding:
      position: 100
      prefix: --bt2-L
  - id: bt2_D
    type:
      - 'null'
      - int
    doc: 'Discard alignments if over this many consecutive seed extensions fail [default:
      4]'
    inputBinding:
      position: 100
      prefix: --bt2-D
  - id: bt2_R
    type:
      - 'null'
      - int
    doc: 'Re-seed reads with repetitive seeds up to this many times [default: 2]'
    inputBinding:
      position: 100
      prefix: --bt2-R
  - id: bt2_gbar
    type:
      - 'null'
      - int
    doc: 'Do not place gaps within this many bases from the end of a read [default:
      4]'
    inputBinding:
      position: 100
      prefix: --bt2-gbar
  - id: bt2_dpad
    type:
      - 'null'
      - int
    doc: 'Pad the alignment matrix with this many bases (to allow gaps) [default:
      2]'
    inputBinding:
      position: 100
      prefix: --bt2-dpad
  - id: bt2_orient
    type:
      - 'null'
      - string
    doc: 'Require paired mates to have this orientation [default: fr]'
    inputBinding:
      position: 100
      prefix: --bt2-orient
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Discard reads with mapping qualities below this threshold [default: 25]'
    inputBinding:
      position: 100
      prefix: --min-mapq
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'Discard alignment maps with fewer than this many reads [default: 1000]'
    inputBinding:
      position: 100
      prefix: --min-reads
  - id: sep_strands
    type:
      - 'null'
      - boolean
    doc: 'Separate each alignment map into forward- and reverse-strand reads [default:
      mix- strands]'
    inputBinding:
      position: 100
      prefix: --sep-strands
  - id: mix_strands
    type:
      - 'null'
      - boolean
    doc: 'Separate each alignment map into forward- and reverse-strand reads [default:
      mix- strands]'
    inputBinding:
      position: 100
      prefix: --mix-strands
  - id: f1r2_fwd
    type:
      - 'null'
      - boolean
    doc: 'With --sep-strands, consider forward mate 1s and reverse mate 2s to be forward-stranded
      [default: f1r2-rev]'
    inputBinding:
      position: 100
      prefix: --f1r2-fwd
  - id: f1r2_rev
    type:
      - 'null'
      - boolean
    doc: 'With --sep-strands, consider forward mate 1s and reverse mate 2s to be forward-stranded
      [default: f1r2-rev]'
    inputBinding:
      position: 100
      prefix: --f1r2-rev
  - id: rev_label
    type:
      - 'null'
      - string
    doc: 'With --sep-strands, add this label to each reverse-strand reference [default:
      -rev]'
    inputBinding:
      position: 100
      prefix: --rev-label
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
