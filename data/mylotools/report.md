# mylotools CWL Generation Report

## mylotools_report

### Tool Description
Generate a report from Myloasm assembly files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/bluenote-1577/mylotools
- **Package**: https://anaconda.org/channels/bioconda/packages/mylotools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mylotools/overview
- **Total Downloads**: 92
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/bluenote-1577/mylotools
- **Stars**: N/A
### Original Help Text
```text
usage: mylotools report [-h] [--fasta FASTA] [--gfa GFA]
                        [--min-length MIN_LENGTH] [--window-size WINDOW_SIZE]
                        [--x-axis {gc,length}] [--workers WORKERS]
                        --output OUTPUT

options:
  -h, --help            show this help message and exit
  --fasta FASTA         Myloasm fasta file (default: assembly_primary.fa)
  --gfa GFA             Path to the GFA file (default: final_contig_graph.gfa)
  --min-length MIN_LENGTH
                        Minimum contig length to include (default: 300000)
  --window-size WINDOW_SIZE
                        Window size for GC content calculation (default: 1000)
  --x-axis {gc,length}  X-axis for summary plot: gc (GC content) or length
                        (contig length) (default: gc)
  --workers WORKERS     Number of parallel workers for plot generation
                        (default: 5)
  --output OUTPUT       Output directory for report files
```


## mylotools_sanitize-headers

### Tool Description
Sanitize FASTA headers

### Metadata
- **Docker Image**: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/bluenote-1577/mylotools
- **Package**: https://anaconda.org/channels/bioconda/packages/mylotools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mylotools sanitize-headers [-h] --fasta FASTA [--no-backup]

options:
  -h, --help     show this help message and exit
  --fasta FASTA  FASTA file to sanitize (will be modified in place)
  --no-backup    Do not create a backup file (default: backup is created)
```


## mylotools_plot

### Tool Description
Plot contig analysis results.

### Metadata
- **Docker Image**: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/bluenote-1577/mylotools
- **Package**: https://anaconda.org/channels/bioconda/packages/mylotools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mylotools plot [-h] [--fasta FASTA] [--gfa GFA] [-w WINDOW_SIZE]
                      [-s STEP_SIZE] [-o OUTPUT] [--marker-size MARKER_SIZE]
                      [--overlap-marker-size OVERLAP_MARKER_SIZE]
                      contig_ids [contig_ids ...]

positional arguments:
  contig_ids            ID of the contig to analyze

options:
  -h, --help            show this help message and exit
  --fasta FASTA         Path to the assembly FASTA file (default:
                        assembly_primary.fa)
  --gfa GFA             Path to the GFA file (default: final_contig_graph.gfa)
  -w, --window-size WINDOW_SIZE
                        Sliding window size in base pairs for GC content
                        (default: 1000)
  -s, --step-size STEP_SIZE
                        Step size for the sliding window (default:
                        window_size/2)
  -o, --output OUTPUT   Output HTML file name (default:
                        contig_id_analysis.html)
  --marker-size MARKER_SIZE
                        Size of marker points in the coverage plot (default:
                        8)
  --overlap-marker-size OVERLAP_MARKER_SIZE
                        Size of marker points in the overlap plot (default:
                        12)
```


## mylotools_strain-viz

### Tool Description
Generate a visualization of contig relationships based on read overlaps.

### Metadata
- **Docker Image**: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/bluenote-1577/mylotools
- **Package**: https://anaconda.org/channels/bioconda/packages/mylotools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mylotools strain-viz [-h] [--overlaps OVERLAPS] [--gfa GFA]
                            [--max-reads MAX_READS] [--output OUTPUT]
                            contigs [contigs ...]

positional arguments:
  contigs               List of contig IDs to include

options:
  -h, --help            show this help message and exit
  --overlaps OVERLAPS   Path to the overlaps file (default:
                        0-cleaning_and_unitigs/overlaps.txt.gz)
  --gfa GFA             Path to the GFA file containing contig information
                        (default: final_contig_graph.gfa)
  --max-reads MAX_READS
                        Maximum number of reads to display per contig
                        (default: 20)
  --output OUTPUT       Output file for the visualization PNG, PDF, SVG, etc.
                        (default: do not save; output to terminal)
```


## mylotools_extract-contigs

### Tool Description
Extract contigs based on minimum length from a Myloasm fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/bluenote-1577/mylotools
- **Package**: https://anaconda.org/channels/bioconda/packages/mylotools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mylotools extract-contigs [-h] [--min-contig-length MIN_CONTIG_LENGTH]
                                 [--fasta FASTA] --output-folder OUTPUT_FOLDER

options:
  -h, --help            show this help message and exit
  --min-contig-length MIN_CONTIG_LENGTH
                        Minimum contig length to extract (default: 300000)
  --fasta FASTA         Myloasm fasta file (default: assembly_primary.fa)
  --output-folder OUTPUT_FOLDER
                        Output directory
```


## Metadata
- **Skill**: generated
