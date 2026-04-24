cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snaptools
  - snap-pre
label: snaptools_snap-pre
doc: "Preprocess single-cell ATAC-seq data into snap format.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: a txt file contains pre-selected cell barcodes. If --barcode-file is 
      given, snaptools will ignore any barcodes not present in the 
      --barcode-file. If it is None, snaptools will automatically identify 
      barcodes from bam file. The first column of --barcode-file must be the 
      selected barcodes and the other columns could be any attributes of the 
      barcode as desired (`ATGCTCTACTAC attr1 att2`). The attributes, however, 
      will not be kept in the snap file. This tag will be ignored if the output 
      snap file already exists.
    inputBinding:
      position: 101
      prefix: --barcode-file
  - id: genome_name
    type: string
    doc: genome identifier (i.e. hg19, mm10). This tag does not change anything 
      unless merge or compare multiple snap files.
    inputBinding:
      position: 101
      prefix: --genome-name
  - id: genome_size
    type: File
    doc: a txt file contains corresponding genome sizes. It must be in the 
      following format with the first column the chromsome name and the second 
      column as chromsome length. This tag does not change anything unless merge
      or compare multiple snap files.
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: input_file
    type: File
    doc: input bam, bed or bed.gz file.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: keep_chrm
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates whether to keep fragments mapped to chrM. If set
      Fasle, fragments aligned to the mitochondrial sequence will be filtered.
    inputBinding:
      position: 101
      prefix: --keep-chrm
  - id: keep_discordant
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates whether to keep discordant read pairs.
    inputBinding:
      position: 101
      prefix: --keep-discordant
  - id: keep_secondary
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates whether to keep secondary alignments. If False, 
      secondary alignments will be filtered. If True, a secondary alignments 
      will be treated as fragments just single-end.
    inputBinding:
      position: 101
      prefix: --keep-secondary
  - id: keep_single
    type:
      - 'null'
      - boolean
    doc: 'a boolen tag indicates whether to keep those reads whose mates are not mapped
      or missing. If False, unpaired reads will be filtered. If True, unpaired reads
      will be simply treated as a fragment. Note: for single-end such as scTHS-seq,
      --keep-single must be True.'
    inputBinding:
      position: 101
      prefix: --keep-single
  - id: max_flen
    type:
      - 'null'
      - int
    doc: max fragment length. Fragments of length longer than --max-flen will be
      filtered.
    inputBinding:
      position: 101
      prefix: --max-flen
  - id: max_num
    type:
      - 'null'
      - int
    doc: max number of barcodes to store. Barcodes are sorted based on the 
      coverage and only the top --max-num barcodes will be stored.
    inputBinding:
      position: 101
      prefix: --max-num
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'min number of fragments per barcode. barcodes of total fragments fewer than
      --min-cov will be considered when creating the cell x bin count matrix. Note:
      because the vast majority of barcodes contains very few reads, we found by setting
      --min-cov, one can remove barcodes of low coverage without wasting time and
      storage. Please note that this is not selection of good barcodes for downstream
      clustering analysis, it is only filterationof very low-quality barcodes.'
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_flen
    type:
      - 'null'
      - int
    doc: min fragment length. Fragments of length shorted than --min-flen will 
      be filtered.
    inputBinding:
      position: 101
      prefix: --min-flen
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: min mappability score. Fargments with mappability score less than 
      --min-mapq will be filtered.
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates whether to overwrite the matrix session if it 
      already exists.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: qc_file
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates whether to create a master qc file. This .qc 
      file contains basic quality control metrics at the bulk level. Quality 
      control is only estimated by selected barcodes only.
    inputBinding:
      position: 101
      prefix: --qc-file
  - id: tmp_folder
    type:
      - 'null'
      - Directory
    doc: a directory to store temporary files. If not given, snaptools will 
      automatically generate a temporary location to store temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-folder
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates output the progress.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_snap
    type: File
    doc: output snap file.
    outputBinding:
      glob: $(inputs.output_snap)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
