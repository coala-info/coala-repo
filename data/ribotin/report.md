# ribotin CWL Generation Report

## ribotin_ribotin-ref

### Tool Description
Ribotin reference-based analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotin:1.5--h077b44d_0
- **Homepage**: https://github.com/maickrau/ribotin
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ribotin/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-07-28
- **GitHub**: https://github.com/maickrau/ribotin
- **Stars**: N/A
### Original Help Text
```text
ribotin-ref version bioconda 1.5

Usage:
  ribotin-ref [OPTION...]

  -h, --help                    Print help
  -v, --version                 Print version
  -i, --in arg                  Input HiFi/duplex reads. Multiple files can 
                                be input with -i file1.fa -i file2.fa etc 
                                (required)
      --nano arg                Input ultralong ONT reads. Multiple files 
                                can be input with --nano file1.fa --nano 
                                file2.fa etc
  -o, --out arg                 Output folder (default: ./result)
  -r, --reference arg           Reference used for recruiting reads 
                                (required)
  -t arg                        Number of threads (default: 1)
  -x arg                        Preset parameters
      --sample-name arg         Name of the sample added to all morph names
      --orient-by-reference arg
                                Rotate and possibly reverse complement the 
                                consensus to match the orientation of the 
                                given reference
      --approx-morphsize arg    Approximate length of one morph
      --extra-phasing           (Experimental) Use extra phasing heuristics 
                                during nanopore analysis. Not recommended 
                                for r9 nanopore reads.
  -k arg                        k-mer size (default: 101)
      --annotation-reference-fasta arg
                                Lift over the annotations from given 
                                reference fasta+gff3 (requires liftoff)
      --annotation-gff3 arg     Lift over the annotations from given 
                                reference fasta+gff3 (requires liftoff)
      --morph-cluster-maxedit arg
                                Maximum edit distance between two morphs to 
                                assign them into the same cluster (default: 
                                200)
      --morph-recluster-minedit arg
                                Minimum edit distance to recluster morphs 
                                (default: 5)
      --mbg arg                 MBG path
      --graphaligner arg        GraphAligner path
      --winnowmap arg           winnowmap/minimap path
      --samtools arg            samtools path
      --verbose                 Print extra debug information

Valid presets for -x: human
```


## ribotin_ribotin-verkko

### Tool Description
ribotin-verkko version bioconda 1.5

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotin:1.5--h077b44d_0
- **Homepage**: https://github.com/maickrau/ribotin
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotin/overview
- **Validation**: PASS

### Original Help Text
```text
ribotin-verkko version bioconda 1.5

Usage:
  ribotin-verkko [OPTION...]

  -h, --help                    Print help
  -v, --version                 Print version
  -i, --in arg                  Input verkko folder (required)
  -o, --out arg                 Output folder prefix (default: ./result)
  -c, --tangles arg             Input files for node tangles. Multiple 
                                files may be inputed with -c file1.txt -c 
                                file2.txt ... (required)
      --guess-tangles-using-reference arg
                                Guess the rDNA tangles using k-mer matches 
                                to given reference sequence (required)
      --do-ul arg               Do ONT read analysis (yes/no/as_verkko) 
                                (default: as_verkko)
      --ul-tmp-folder arg       Temporary folder for ultralong ONT read 
                                analysis (default: ./tmp)
  -t arg                        Number of threads (default: 1)
  -x arg                        Preset parameters
      --sample-name arg         Name of the sample added to all morph names
      --orient-by-reference arg
                                Rotate and possibly reverse complement the 
                                consensus to match the orientation of the 
                                given reference
      --approx-morphsize arg    Approximate length of one morph
      --extra-phasing           (Experimental) Use extra phasing heuristics 
                                during nanopore analysis. Not recommended 
                                for r9 nanopore reads.
  -k arg                        k-mer size (default: 101)
      --annotation-reference-fasta arg
                                Lift over the annotations from given 
                                reference fasta+gff3 (requires liftoff)
      --annotation-gff3 arg     Lift over the annotations from given 
                                reference fasta+gff3 (requires liftoff)
      --morph-cluster-maxedit arg
                                Maximum edit distance between two morphs to 
                                assign them into the same cluster (default: 
                                200)
      --morph-recluster-minedit arg
                                Minimum edit distance to recluster morphs 
                                (default: 5)
      --mbg arg                 MBG path
      --graphaligner arg        GraphAligner path
      --winnowmap arg           winnowmap/minimap path
      --samtools arg            samtools path
      --verbose                 Print extra debug information

Valid presets for -x: human
```


## ribotin_ribotin-hifiasm

### Tool Description
A tool for assembling genomes using hifiasm, with support for various read types and advanced phasing options.

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotin:1.5--h077b44d_0
- **Homepage**: https://github.com/maickrau/ribotin
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotin/overview
- **Validation**: PASS

### Original Help Text
```text
ribotin-hifiasm version bioconda 1.5

Usage:
  ribotin-hifiasm [OPTION...]

  -h, --help                    Print help
  -v, --version                 Print version
  -a, --assembly arg            Input hifiasm assembly prefix (required)
  -i, --hifi arg                Input hifi reads (required)
      --nano arg                Input ultralong ONT reads
  -o, --out arg                 Output folder prefix (default: ./result)
  -c, --tangles arg             Input files for node tangles. Multiple 
                                files may be inputed with -c file1.txt -c 
                                file2.txt ... (required)
      --guess-tangles-using-reference arg
                                Guess the rDNA tangles using k-mer matches 
                                to given reference sequence (required)
      --ul-tmp-folder arg       Temporary folder for ultralong ONT read 
                                analysis (default: ./tmp)
  -t arg                        Number of threads (default: 1)
  -x arg                        Preset parameters
      --sample-name arg         Name of the sample added to all morph names
      --orient-by-reference arg
                                Rotate and possibly reverse complement the 
                                consensus to match the orientation of the 
                                given reference
      --approx-morphsize arg    Approximate length of one morph
      --extra-phasing           (Experimental) Use extra phasing heuristics 
                                during nanopore analysis. Not recommended 
                                for r9 nanopore reads.
  -k arg                        k-mer size (default: 101)
      --annotation-reference-fasta arg
                                Lift over the annotations from given 
                                reference fasta+gff3 (requires liftoff)
      --annotation-gff3 arg     Lift over the annotations from given 
                                reference fasta+gff3 (requires liftoff)
      --morph-cluster-maxedit arg
                                Maximum edit distance between two morphs to 
                                assign them into the same cluster (default: 
                                200)
      --morph-recluster-minedit arg
                                Minimum edit distance to recluster morphs 
                                (default: 5)
      --mbg arg                 MBG path
      --graphaligner arg        GraphAligner path
      --winnowmap arg           winnowmap/minimap path
      --samtools arg            samtools path
      --verbose                 Print extra debug information

Valid presets for -x: human
```


## Metadata
- **Skill**: generated
