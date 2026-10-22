cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - align
label: seismic-rna_seismic_align
doc: 'Trim FASTQ files and align them to reference sequences.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: fasta
    type: File
    doc: FASTA file of reference sequences
    inputBinding:
      position: 200
  - id: fastqx
    type:
      - 'null'
      - type: array
        items: fastqx_rec
        inputBinding:
          position: 100
    doc: FASTQ files of paired-end reads with mates 1 and 2 in separate files (give
      the option once per file or directory)
  - id: fastqy
    type:
      - 'null'
      - type: array
        items: fastqy_rec
        inputBinding:
          position: 100
    doc: FASTQ file(s) of paired-end reads with mates 1 and 2 interleaved (give the
      option once per file or directory)
  - id: fastqz
    type:
      - 'null'
      - type: array
        items: fastqz_rec
        inputBinding:
          position: 100
    doc: FASTQ file(s) of single-end reads (give the option once per file or directory)
  - id: dmfastqx
    type:
      - 'null'
      - type: array
        items: dmfastqx_rec
        inputBinding:
          position: 100
    doc: Demultiplexed FASTQ files of mate 1 and mate 2 reads (give the option once
      per file or directory)
  - id: dmfastqy
    type:
      - 'null'
      - type: array
        items: dmfastqy_rec
        inputBinding:
          position: 100
    doc: Demultiplexed FASTQ files of paired-end reads interleaved in one file (give
      the option once per file or directory)
  - id: dmfastqz
    type:
      - 'null'
      - type: array
        items: dmfastqz_rec
        inputBinding:
          position: 100
    doc: Demultiplexed FASTQ files of single-end reads (give the option once per file
      or directory)
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
  - id: fastp
    type:
      - 'null'
      - boolean
    doc: 'Use fastp to QC, filter, and trim reads before alignment [default: fastp]'
    inputBinding:
      position: 100
      prefix: --fastp
  - id: no_fastp
    type:
      - 'null'
      - boolean
    doc: 'Use fastp to QC, filter, and trim reads before alignment [default: fastp]'
    inputBinding:
      position: 100
      prefix: --no-fastp
  - id: fastp_5
    type:
      - 'null'
      - boolean
    doc: 'Trim low-quality bases from the 5'' ends of reads [default: no-fastp-5]'
    inputBinding:
      position: 100
      prefix: --fastp-5
  - id: no_fastp_5
    type:
      - 'null'
      - boolean
    doc: 'Trim low-quality bases from the 5'' ends of reads [default: no-fastp-5]'
    inputBinding:
      position: 100
      prefix: --no-fastp-5
  - id: fastp_3
    type:
      - 'null'
      - boolean
    doc: 'Trim low-quality bases from the 3'' ends of reads [default: fastp-3]'
    inputBinding:
      position: 100
      prefix: --fastp-3
  - id: no_fastp_3
    type:
      - 'null'
      - boolean
    doc: 'Trim low-quality bases from the 3'' ends of reads [default: fastp-3]'
    inputBinding:
      position: 100
      prefix: --no-fastp-3
  - id: fastp_w
    type:
      - 'null'
      - int
    doc: 'Use this window size (nt) for --fastp-5 and --fastp-3 [default: 6]'
    inputBinding:
      position: 100
      prefix: --fastp-w
  - id: fastp_m
    type:
      - 'null'
      - int
    doc: 'Use this mean quality threshold for --fastp-5 and --fastp-3 [default: 25]'
    inputBinding:
      position: 100
      prefix: --fastp-m
  - id: fastp_poly_g
    type:
      - 'null'
      - string
    doc: 'Trim poly(G) tails (two-color sequencing artifacts) from the 3'' end [default:
      auto]'
    inputBinding:
      position: 100
      prefix: --fastp-poly-g
  - id: fastp_poly_g_min_len
    type:
      - 'null'
      - int
    doc: 'Minimum number of Gs to consider a poly(G) tail for --fastp-poly-g [default:
      10]'
    inputBinding:
      position: 100
      prefix: --fastp-poly-g-min-len
  - id: fastp_poly_x
    type:
      - 'null'
      - boolean
    doc: ' Trim poly(X) tails (i.e. of any nucleotide) from the 3'' end [default:
      no-fastp-poly-x]'
    inputBinding:
      position: 100
      prefix: --fastp-poly-x
  - id: no_fastp_poly_x
    type:
      - 'null'
      - boolean
    doc: ' Trim poly(X) tails (i.e. of any nucleotide) from the 3'' end [default:
      no-fastp-poly-x]'
    inputBinding:
      position: 100
      prefix: --no-fastp-poly-x
  - id: fastp_poly_x_min_len
    type:
      - 'null'
      - int
    doc: 'Minimum number of bases to consider a poly(X) tail for --fastp-poly-x [default:
      10]'
    inputBinding:
      position: 100
      prefix: --fastp-poly-x-min-len
  - id: fastp_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: ' Trim adapter sequences from the 3'' ends of reads [default: fastp-adapter-trimming]'
    inputBinding:
      position: 100
      prefix: --fastp-adapter-trimming
  - id: no_fastp_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: ' Trim adapter sequences from the 3'' ends of reads [default: fastp-adapter-trimming]'
    inputBinding:
      position: 100
      prefix: --no-fastp-adapter-trimming
  - id: fastp_adapter_1
    type:
      - 'null'
      - string
    doc: 'Trim this adapter sequence from the 3'' ends of read 1s [default: ""]'
    inputBinding:
      position: 100
      prefix: --fastp-adapter-1
  - id: fastp_adapter_2
    type:
      - 'null'
      - string
    doc: 'Trim this adapter sequence from the 3'' ends of read 2s [default: ""]'
    inputBinding:
      position: 100
      prefix: --fastp-adapter-2
  - id: fastp_adapter_fasta
    type:
      - 'null'
      - File
    doc: Trim adapter sequences in this FASTA file from the 3' ends of reads
    inputBinding:
      position: 100
      prefix: --fastp-adapter-fasta
  - id: fastp_detect_adapter_for_pe
    type:
      - 'null'
      - boolean
    doc: ' Automatically detect the adapter sequences for paired-end reads [default:
      fastp- detect-adapter-for-pe]'
    inputBinding:
      position: 100
      prefix: --fastp-detect-adapter-for-pe
  - id: no_fastp_detect_adapter_for_pe
    type:
      - 'null'
      - boolean
    doc: ' Automatically detect the adapter sequences for paired-end reads [default:
      fastp- detect-adapter-for-pe]'
    inputBinding:
      position: 100
      prefix: --no-fastp-detect-adapter-for-pe
  - id: fastp_min_length
    type:
      - 'null'
      - int
    doc: 'Discard reads shorter than this length [default: 9]'
    inputBinding:
      position: 100
      prefix: --fastp-min-length
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
  - id: bt2_score_min_e2e
    type:
      - 'null'
      - string
    doc: 'Discard alignments that score below this threshold in end-to-end mode [default:
      L,-1,-0.8]'
    inputBinding:
      position: 100
      prefix: --bt2-score-min-e2e
  - id: bt2_score_min_loc
    type:
      - 'null'
      - string
    doc: 'Discard alignments that score below this threshold in local mode [default:
      L,1,0.8]'
    inputBinding:
      position: 100
      prefix: --bt2-score-min-loc
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
  - id: bt2_gbar
    type:
      - 'null'
      - int
    doc: 'Do not place gaps within this many bases from the end of a read [default:
      4]'
    inputBinding:
      position: 100
      prefix: --bt2-gbar
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
  - id: bt2_un
    type:
      - 'null'
      - boolean
    doc: 'Output unaligned reads to a FASTQ file [default: bt2-un]'
    inputBinding:
      position: 100
      prefix: --bt2-un
  - id: bt2_no_un
    type:
      - 'null'
      - boolean
    doc: 'Output unaligned reads to a FASTQ file [default: bt2-un]'
    inputBinding:
      position: 100
      prefix: --bt2-no-un
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
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: fastqx_rec
        type: record
        fields:
          - name: fastq
            type:
              - File
              - Directory
            inputBinding:
              position: 1
              prefix: --fastqx
      - name: fastqy_rec
        type: record
        fields:
          - name: fastq
            type:
              - File
              - Directory
            inputBinding:
              position: 1
              prefix: --fastqy
      - name: fastqz_rec
        type: record
        fields:
          - name: fastq
            type:
              - File
              - Directory
            inputBinding:
              position: 1
              prefix: --fastqz
      - name: dmfastqx_rec
        type: record
        fields:
          - name: fastq
            type:
              - File
              - Directory
            inputBinding:
              position: 1
              prefix: --dmfastqx
      - name: dmfastqy_rec
        type: record
        fields:
          - name: fastq
            type:
              - File
              - Directory
            inputBinding:
              position: 1
              prefix: --dmfastqy
      - name: dmfastqz_rec
        type: record
        fields:
          - name: fastq
            type:
              - File
              - Directory
            inputBinding:
              position: 1
              prefix: --dmfastqz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
