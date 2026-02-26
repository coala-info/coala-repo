# metaclassifier CWL Generation Report

## metaclassifier

### Tool Description
The metaclassifier.py uses DNA metabarcoding sequence reads and a database of marker sequences, including corresponding taxonomy classes to identify and quantify the floral composition of honey

### Metadata
- **Docker Image**: quay.io/biocontainers/metaclassifier:v1.0.1--py_0
- **Homepage**: https://github.com/ewafula/MetaClassifier
- **Package**: https://anaconda.org/channels/bioconda/packages/metaclassifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaclassifier/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ewafula/MetaClassifier
- **Stars**: N/A
### Original Help Text
```text
usage: metaclassifier [-h] [-o OUTPUT_DIR] [-f {paired,single}] [-m]
                      [-c {order,family,genus,species}] [-p MIN_PROPORTION]
                      [-i MAX_MARKERS] [-r PEAR_MERGER] [-s SEQTK_CONVERTER]
                      [-a VSEARCH_ALIGNER] [-t THREADS] [-v]
                      SAMPLE_FILE DB_DIR CONFIG_FILE

The metaclassifier.py uses DNA metabarcoding sequence reads and a database of marker sequences, including
corresponding taxonomy classes to identify and quantify the floral composition of honey

positional arguments:
  SAMPLE_FILE           Input tab-delimited file specifying sample names, file names for forward paired-end
                        reads, and file names for reverse paired-end (file path if not in working directory)
                        The second file not required for single-end frangments
                        
  DB_DIR                Input marker database directory with sequence fasta and corresponding taxonomy lineage
                        files for each marker
                        
  CONFIG_FILE           Input tab-delimited file specifying marker name, and its corresponding VSEARCH's
                        usearch_global function minimum query coverage (i.e. 0.8 for 80%) and minimun sequence
                        identity (i.e. 0.95 for 95%) for each search marker (provide the file path if not in
                        if the VSEARCH settings configuration is not in working directory)
                        

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Specify output directory name, otherwise it will automatically be created using the
                        input sample table file name
                        
  -f {paired,single}, --frag_type {paired,single}
                        Specify the sequence fragment type in the input sample file, available options are:
                        paired: single-end read fragments (default)
                        single: paired-end read fragments
                        
  -m, --merge           Merge overlapping paired-end reads (default: False)
                        
  -c {order,family,genus,species}, --tax_class {order,family,genus,species}
                        Taxonomy class for quantify taxon level marker read abundance (default: genus)
                        
  -p MIN_PROPORTION, --min_proportion MIN_PROPORTION
                        Minimum taxon read proportion allowed to retain a sample taxon, allowed proportion,
                        ranges from 0.00 to 0.01 (default = 0.00)
                        
  -i MAX_MARKERS, --max_markers MAX_MARKERS
                        Maximum missing markers allowed to retain a sample taxon (default = 0)
                        
  -r PEAR_MERGER, --pear_merger PEAR_MERGER
                        Path to PEAR, the paired-end read merger if not in environmental variables (ENV)
                        (default: read from ENV)
                        
  -s SEQTK_CONVERTER, --seqtk_converter SEQTK_CONVERTER
                        Path to seqtk, the sequence processing tool if not in environmental variables (ENV)
                        (default: read from ENV)
                        
  -a VSEARCH_ALIGNER, --vsearch_aligner VSEARCH_ALIGNER
                        Path to VSEARCH, the sequence analysis tool if not in environmental variables (ENV)
                        (default: read from ENV)
                        
  -t THREADS, --threads THREADS
                        Specify the number of threads to use (default: 2)
                        
  -v, --version         Print the current metaclassifier.py version and exit
```

