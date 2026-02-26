cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegasusio aggregate_matrix
label: pegasusio_aggregate_matrix
doc: "Aggregate multiple single-modality or multi-modality data into one big MultimodalData
  object and write it back to disk as a zipped Zarr file.\n\nTool homepage: https://github.com/klarman-cell-observatory/pegasusio"
inputs:
  - id: csv_file
    type: File
    doc: csv_file should contains at least 2 columns — Sample, sample name; 
      Location, file that contains the count matrices (e.g. 
      filtered_gene_bc_matrices_h5.h5), and merges matrices from the same genome
      together. If multi-modality exists, a third Modality column might be 
      required. The csv_file can optionally contain two columns - nUMI and 
      nGene. These two columns define minimum number of UMIs and genes for cell 
      selection for each sample. The values in these two columns overwrite the 
      min_genes and min_umis arguments.
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: The output file name.
    inputBinding:
      position: 2
  - id: attributes
    type:
      - 'null'
      - string
    doc: Specify a comma-separated list of outputted attributes. These 
      attributes should be column names in the csv file.
    inputBinding:
      position: 103
      prefix: --attributes
  - id: default_reference
    type:
      - 'null'
      - string
    doc: If sample count matrix is in either DGE, mtx, csv, tsv or loom format 
      and there is no Reference column in the csv_file, use <reference> as the 
      reference. This option can also be used for replacing genome names. For 
      example, if <reference> is 'hg19:GRCh38,GRCh38', we will change any genome
      with name 'hg19' to 'GRCh38' and if no genome is provided, 'GRCh38' is the
      default.
    inputBinding:
      position: 103
      prefix: --default-reference
  - id: max_genes
    type:
      - 'null'
      - int
    doc: Only keep cells with less than <number> of genes.
    inputBinding:
      position: 103
      prefix: --max-genes
  - id: max_umis
    type:
      - 'null'
      - int
    doc: Only keep cells with less than <number> of UMIs.
    inputBinding:
      position: 103
      prefix: --max-umis
  - id: min_genes
    type:
      - 'null'
      - int
    doc: Only keep cells with at least <number> of genes.
    inputBinding:
      position: 103
      prefix: --min-genes
  - id: min_umis
    type:
      - 'null'
      - int
    doc: Only keep cells with at least <number> of UMIs.
    inputBinding:
      position: 103
      prefix: --min-umis
  - id: mito_prefix
    type:
      - 'null'
      - string
    doc: Prefix for mitochondrial genes. If multiple prefixes are provided, 
      separate them by comma (e.g. "MT-,mt-").
    inputBinding:
      position: 103
      prefix: --mito-prefix
  - id: no_append_sample_name
    type:
      - 'null'
      - boolean
    doc: Turn this option on if you do not want to append sample name in front 
      of each sample's barcode (concatenated using '-').
    inputBinding:
      position: 103
      prefix: --no-append-sample-name
  - id: percent_mito
    type:
      - 'null'
      - float
    doc: Only keep cells with mitochondrial percent less than <percent>%. Only 
      when both mito_prefix and percent_mito set, the mitochondrial filter will 
      be triggered.
    inputBinding:
      position: 103
      prefix: --percent-mito
  - id: remap_singlets
    type:
      - 'null'
      - string
    doc: "Remap singlet names using <remap_string>, where <remap_string> takes the
      format \"new_name_i:old_name_1,old_name_2;new_name_ii:old_name_3;...\". For
      example, if we hashed 5 libraries from 3 samples sample1_lib1, sample1_lib2,
      sample2_lib1, sample2_lib2 and sample3, we can remap them to 3 samples using
      this string: \"sample1:sample1_lib1,sample1_lib2;sample2:sample2_lib1,sample2_lib2\"\
      . In this way, the new singlet names will be in metadata field with key 'assignment',
      while the old names will be kept in metadata field with key 'assignment.orig'."
    inputBinding:
      position: 103
      prefix: --remap-singlets
  - id: restriction
    type:
      - 'null'
      - type: array
        items: string
    doc: Select data that satisfy all restrictions. Each restriction takes the 
      format of name:value,...,value or name:~value,..,value, where ~ refers to 
      not. You can specifiy multiple restrictions by setting this option 
      multiple times.
    inputBinding:
      position: 103
      prefix: --restriction
  - id: select_only_singlets
    type:
      - 'null'
      - boolean
    doc: If we have demultiplexed data, turning on this option will make 
      pegasusio only include barcodes that are predicted as singlets.
    inputBinding:
      position: 103
      prefix: --select-only-singlets
  - id: subset_singlets
    type:
      - 'null'
      - string
    doc: If select singlets, only select singlets in the <subset_string>, which 
      takes the format "name1,name2,...". Note that if --remap-singlets is 
      specified, subsetting happens after remapping. For example, we can only 
      select singlets from sampe 1 and 3 using "sample1,sample3".
    inputBinding:
      position: 103
      prefix: --subset-singlets
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegasusio:0.10.0--py311haab0aaa_0
stdout: pegasusio_aggregate_matrix.out
