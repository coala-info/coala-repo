# cats-rb CWL Generation Report

## cats-rb_CATS_rb_index

### Tool Description
genome index generation script

### Metadata
- **Docker Image**: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/bodulic/CATS-rb
- **Package**: https://anaconda.org/channels/bioconda/packages/cats-rb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cats-rb/overview
- **Total Downloads**: 627
- **Last updated**: 2025-09-27
- **GitHub**: https://github.com/bodulic/CATS-rb
- **Stars**: N/A
### Original Help Text
```text
25/02/2026 19:31:27:ERROR: Unknown flag supplied: --
CATS-rb version 1.0.3 - genome index generation script
USAGE /usr/local/bin/CATS_rb_index [OPTIONS] GENOME
Genome index generation options:
-m: Maximum gene length (in bp), default: estimated from genome size
General options:
-t: Number of CPU threads, default: 10
-O: Overwrite the genome index directory, default: off
-h: Show usage information
```


## cats-rb_CATS_rb_map

### Tool Description
transcriptome assembly mapping script

### Metadata
- **Docker Image**: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/bodulic/CATS-rb
- **Package**: https://anaconda.org/channels/bioconda/packages/cats-rb/overview
- **Validation**: PASS

### Original Help Text
```text
25/02/2026 19:31:45:ERROR: Unknown flag supplied: --
CATS-rb version 1.0.3 - transcriptome assembly mapping script
USAGE /usr/local/bin/CATS_rb_map [OPTIONS] GENOME_INDEX_DIR TRANSCRIPTOME
Mapping options:
-S: Enable stranded mapping, default: off
-N: Maximum number of mappings per transcript, default: 5
-i: Minimum intron length (in bp), default: 20
-p: Species-specific preset (from path_to_spaln_dir/table/), default: unset
-s: Splice site characterization option (0-3, refer to documentation), default: 2
-P: Relative contribution of coding potential to mapping score, default: 1
-T: Relative contribution of translation initiation signal to mapping score, default: 1
General options:
-t: Number of CPU threads, default: 10
-D: Mapping output directory name, default: TRANSCRIPTOME_CATS_rb_map
-O: Overwrite the mapping output directory, default: off
-h: Show usage information
```


## cats-rb_CATS_rb_compare

### Tool Description
transcriptome assembly comparison script

### Metadata
- **Docker Image**: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/bodulic/CATS-rb
- **Package**: https://anaconda.org/channels/bioconda/packages/cats-rb/overview
- **Validation**: PASS

### Original Help Text
```text
25/02/2026 19:32:20:ERROR: Unknown flag supplied: --
CATS-rb version 1.0.3 - transcriptome assembly comparison script
USAGE /usr/local/bin/CATS_rb_compare [OPTIONS] GENOME TRANSCRIPTOME_MAP_DIR1 ...
Mapping comparison options:
-S: Enable stranded analysis, default: off
-p: Minimum exon identity proportion, default: 0.98
-e: Minimum exon length (in bp), default: 20
-i: Maximum intron length (in bp), default: 100000
-M: Alignment proportion threshold for structural inconsistency detection, default: 0.9
-C: Maximum proportion of allowed transcript segment overlap for identification of segments mapping to disjunct genomic regions, default: 0.3
-l: Minimum exon set length for completeness analysis (in bp), default: 0
-L: Minimum transcript set length for completeness analysis (in bp), default: 100
-m: Maximum transcript set length for completeness analysis (in bp), default: 1000000
-j: Minimum overlap between exon sets for edge specification (in bp), default: 1
-J: Minimum overlap between transcript sets for edge specification (in bp), default: 1
-o: Minimum overlap between transcript set and transcript for isoform specification (in bp), default: 1
-P: Transcript set proximity region length for unique exon set analysis (in bp), default: 5000
-x: Figure extension, default: png
-d: Figure DPI, default: 600
-r: Raincloud plot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted Set1 palette from RColorBrewer package
-b: Barplot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted YlOrRd palette from RColorBrewer package
-n: Exon set genomic location plot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted Set1 palette from RColorBrewer package
-u: UpSet plot bar and matrix colors (quoted hexadecimal codes or R color names, specified with x,y), default: #FDAF4A,#DC151D
-v: Venn diagram colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted Reds palette from RColorBrewer package
-y: Pairwise similarity tileplot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted YlOrRd palette from RColorBrewer package
-c: Hierarchical clustering heatmap colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted YlOrRd palette from RColorBrewer package
-q: Maximum right-tail distribution quantile for raincloud plots, default: 0.995
-f: Number of longest genomic scaffolds for exon set genomic location plot, default: all scaffolds
-B: Number of genomic bins for exon set genomic location plot, default: 25000
-V: Minimum completeness threshold for assigning an element set to a Venn set, default: 0.35
-H: Number of longest element sets used in hierarchical clustering, default: 5000
-E: Use raster for heatmap plotting, default: off
-A: Proportion of aligned transcript distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
-N: Number of exons per transcript distribution breakpoints (specified with x,y,z...), default: 1,2,4,6,8,10,15,20
-R: Common element set relative length distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
-I: Number of isoforms per transcript set distribution breakpoints (specified with x,y,z...), default: 1,2,4,6,8,10,15,20
Annotation-based analysis options (requires a GTF/GFF3 file to be supplied):
-F: GTF/GFF3 file for the annotation-based analysis
-g: Minimum proportion of an exon set that must be covered to be considered a match to a GTF exon set (and vice versa); default: 0.35
-G: Minimum proportion of a transcript set that must be covered to be considered a match to a GTF transcript set (and vice versa); default: 0.35
-s: Proportion of element sets covered by a GTF set distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
General options:
-t: Number of CPU threads, default: 10
-D: Comparison output directory name, default: CATS_rb_comparison
-O: Overwrite the comparison output directory, default: off
-h: Show usage information
```

