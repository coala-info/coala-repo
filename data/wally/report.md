# wally CWL Generation Report

## wally_region

### Tool Description
Display BAM alignments in a specified region.

### Metadata
- **Docker Image**: quay.io/biocontainers/wally:0.7.1--h4d20210_1
- **Homepage**: https://github.com/tobiasrausch/wally
- **Package**: https://anaconda.org/channels/bioconda/packages/wally/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wally/overview
- **Total Downloads**: 22.5K
- **Last updated**: 2025-08-21
- **GitHub**: https://github.com/tobiasrausch/wally
- **Stars**: N/A
### Original Help Text
```text
Usage: wally region [OPTIONS] -g <ref.fa> <sample1.sort.bam> <sample2.sort.bam> ...

Generic options:
  -? [ --help ]                        show help message
  -g [ --genome ] arg                  genome fasta file
  -b [ --bed ] arg                     BED annotation file (optional)

Graphics options:
  -q [ --map-qual ] arg (=1)           min. mapping quality
  -m [ --mad-cutoff ] arg (=9)         insert size cutoff, median+m*MAD
  -v [ --snv-vaf ] arg (=0.200000003)  min. SNV VAF
  -t [ --snv-cov ] arg (=10)           min. SNV coverage
  -r [ --region ] arg (=chrA:35-78)    region to display
  -R [ --rfile ] arg                   BED file with regions to display
  -p [ --paired ]                      paired-end view
  -u [ --supplementary ]               show supplementary alignments
  -c [ --clip ]                        show soft- and hard-clips

Display options:
  -s [ --split ] arg (=1)              number of horizontal images
  -x [ --width ] arg (=1024)           width of the plot
  -y [ --height ] arg (=1024)          height of the plot
```


## wally_matches

### Tool Description
Display matches from BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/wally:0.7.1--h4d20210_1
- **Homepage**: https://github.com/tobiasrausch/wally
- **Package**: https://anaconda.org/channels/bioconda/packages/wally/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wally matches [OPTIONS] -g <ref.fa> <input.bam>

Generic options:
  -? [ --help ]                        show help message
  -g [ --genome ] arg                  genome fasta file
  -r [ --read ] arg (=read_name)       read to display
  -R [ --rfile ] arg                   file with reads to display
  -s [ --size ] arg (=0)               min. sequence size to include
  -q [ --seqfile ] arg                 sequence output file [optional]
  -o [ --outfile ] arg (="out.png")    plot output file
  -p [ --separate ]                    create one plot for each input read

Display options:
  -n [ --winsize ] arg (=10000)        window size to cluster nearby matches
  -m [ --matches ] arg (=1)            min. number of matches per region
  -t [ --trackheight ] arg (=15)       track height in pixels
  -f [ --ftscale ] arg (=0.400000006)  font scale
  -x [ --width ] arg (=0)              width of the plot [0: best fit]
  -y [ --height ] arg (=0)             height of the plot [0: best fit]
  -l [ --labeloff ]                    turn off node labeling
```


## wally_dotplot

### Tool Description
Generates dot plots for sequence alignment visualization.

### Metadata
- **Docker Image**: quay.io/biocontainers/wally:0.7.1--h4d20210_1
- **Homepage**: https://github.com/tobiasrausch/wally
- **Package**: https://anaconda.org/channels/bioconda/packages/wally/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wally dotplot [OPTIONS] -g <ref.fa> -R <reads.lst> <sample.bam>
       wally dotplot [OPTIONS] <sample.fa>

Generic options:
  -? [ --help ]                  show help message
  -g [ --genome ] arg            genome fasta file
  -m [ --matchlen ] arg (=11)    default match length
  -s [ --size ] arg (=0)         min. sequence size to include
  -q [ --seqfile ] arg           sequence output file [optional]
  -a [ --selfalign ]             incl. self alignments
  -p [ --flip ]                  flip x and y-axis

BAM mode:
  -r [ --read ] arg              read to display
  -R [ --rfile ] arg             file with reads to display
  -e [ --region ] arg            region to display [chrA:35-78]
  -E [ --reglist ] arg           BED file with regions to display
  -f [ --flatten ]               flatten mapping segments

Display options:
  -l [ --linewidth ] arg (=1.5)  match line width
  -x [ --width ] arg (=0)        width of the plot [0: best fit]
  -y [ --height ] arg (=0)       height of the plot [0: best fit]
```

