# pegasusio CWL Generation Report

## pegasusio_aggregate_matrix

### Tool Description
Aggregate multiple single-modality or multi-modality data into one big MultimodalData object and write it back to disk as a zipped Zarr file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pegasusio:0.10.0--py311haab0aaa_0
- **Homepage**: https://github.com/klarman-cell-observatory/pegasusio
- **Package**: https://anaconda.org/channels/bioconda/packages/pegasusio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pegasusio/overview
- **Total Downloads**: 100.5K
- **Last updated**: 2025-05-22
- **GitHub**: https://github.com/klarman-cell-observatory/pegasusio
- **Stars**: N/A
### Original Help Text
```text
Aggregate multiple single-modality or multi-modality data into one big MultimodalData object and write it back to disk as a zipped Zarr file.

Usage:
  pegasusio aggregate_matrix <csv_file> <output_name> [--restriction <restriction>... options]
  pegasusio aggregate_matrix -h

Arguments:
  csv_file           csv_file should contains at least 2 columns — Sample, sample name; Location, file that contains the count matrices (e.g. filtered_gene_bc_matrices_h5.h5), and merges matrices from the same genome together. If multi-modality exists, a third Modality column might be required. The csv_file can optionally contain two columns - nUMI and nGene. These two columns define minimum number of UMIs and genes for cell selection for each sample. The values in these two columns overwrite the min_genes and min_umis arguments.
  output_name        The output file name.

Options:
  --restriction <restriction>...           Select data that satisfy all restrictions. Each restriction takes the format of name:value,...,value or name:~value,..,value, where ~ refers to not. You can specifiy multiple restrictions by setting this option multiple times.
  --attributes <attributes>                Specify a comma-separated list of outputted attributes. These attributes should be column names in the csv file.
  --default-reference <reference>          If sample count matrix is in either DGE, mtx, csv, tsv or loom format and there is no Reference column in the csv_file, use <reference> as the reference. This option can also be used for replacing genome names. For example, if <reference> is 'hg19:GRCh38,GRCh38', we will change any genome with name 'hg19' to 'GRCh38' and if no genome is provided, 'GRCh38' is the default.
  --select-only-singlets                   If we have demultiplexed data, turning on this option will make pegasusio only include barcodes that are predicted as singlets.
  --remap-singlets <remap_string>          Remap singlet names using <remap_string>, where <remap_string> takes the format "new_name_i:old_name_1,old_name_2;new_name_ii:old_name_3;...". For example, if we hashed 5 libraries from 3 samples sample1_lib1, sample1_lib2, sample2_lib1, sample2_lib2 and sample3, we can remap them to 3 samples using this string: "sample1:sample1_lib1,sample1_lib2;sample2:sample2_lib1,sample2_lib2". In this way, the new singlet names will be in metadata field with key 'assignment', while the old names will be kept in metadata field with key 'assignment.orig'.
  --subset-singlets <subset_string>        If select singlets, only select singlets in the <subset_string>, which takes the format "name1,name2,...". Note that if --remap-singlets is specified, subsetting happens after remapping. For example, we can only select singlets from sampe 1 and 3 using "sample1,sample3".
  --min-genes <number>                     Only keep cells with at least <number> of genes.
  --max-genes <number>                     Only keep cells with less than <number> of genes. 
  --min-umis <number>                      Only keep cells with at least <number> of UMIs.
  --max-umis <number>                      Only keep cells with less than <number> of UMIs.
  --mito-prefix <prefix>                   Prefix for mitochondrial genes. If multiple prefixes are provided, separate them by comma (e.g. "MT-,mt-").
  --percent-mito <percent>                 Only keep cells with mitochondrial percent less than <percent>%. Only when both mito_prefix and percent_mito set, the mitochondrial filter will be triggered.
  --no-append-sample-name                  Turn this option on if you do not want to append sample name in front of each sample's barcode (concatenated using '-').
  -h, --help                               Print out help information.

Outputs:
  output_name.zarr.zip        A zipped Zarr file containing aggregated data.

Examples:
  pegasusio aggregate_matrix --restriction Source:BM,CB --restriction Individual:1-8 --attributes Source,Platform count_matrix.csv aggr_data
```


## pegasusio_This

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pegasusio:0.10.0--py311haab0aaa_0
- **Homepage**: https://github.com/klarman-cell-observatory/pegasusio
- **Package**: https://anaconda.org/channels/bioconda/packages/pegasusio/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Unknown command This!
```

