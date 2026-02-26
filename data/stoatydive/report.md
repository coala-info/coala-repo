# stoatydive CWL Generation Report

## stoatydive_StoatyDive.py

### Tool Description
The tool can evalute the profile of peaks. Provide the peaks you want to evalutate in bed6 format and the reads
you used for the peak detection in bed or bam format. The user obtains a distributions of the coefficient of variation (CV)
which can be used to evaluate the profile landscape. In addition, the tool generates ranked list for the peaks based
on the CV. The table hast the following columns: Chr Start End ID VC Strand bp r p Max_Norm_VC
Left_Border_Center_Difference Right_Border_Center_Difference. See StoatyDive's development page for a detailed description.

### Metadata
- **Docker Image**: quay.io/biocontainers/stoatydive:1.1.1--pyh5e36f6f_0
- **Homepage**: https://github.com/heylf/StoatyDive
- **Package**: https://anaconda.org/channels/bioconda/packages/stoatydive/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stoatydive/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/heylf/StoatyDive
- **Stars**: N/A
### Original Help Text
```text
[START]
usage: StoatyDive.py [-h] [options] -a *.bed -b *.bam/*bed -c *.txt

    The tool can evalute the profile of peaks. Provide the peaks you want to evalutate in bed6 format and the reads
    you used for the peak detection in bed or bam format. The user obtains a distributions of the coefficient of variation (CV)
    which can be used to evaluate the profile landscape. In addition, the tool generates ranked list for the peaks based
    on the CV. The table hast the following columns: Chr Start End ID VC Strand bp r p Max_Norm_VC
    Left_Border_Center_Difference Right_Border_Center_Difference. See StoatyDive's development page for a detailed description.
    

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -a *.bed, --input_bed *.bed
                        Path to the peak file in bed6 format.
  -b *.bam/*.bed, --input_bam *.bam/*.bed
                        Path to the read file used for the peak calling in bed
                        or bam format.
  -c *.txt, --chr_file *.txt
                        Path to the chromosome length file.
  -o path/, --output_folder path/
                        Write results to this path. [Default: Operating Path]
  -t float, --thresh float
                        Set a normalized CV threshold to divide the peak
                        profiles into more specific (0) and more unspecific
                        (1). [Default: 1.0]
  --peak_correction     Activate peak correction. The peaks are recentered
                        (shifted) for the correct sumit.
  --max_translocate     Set this flag if you want to shift the peak profiles
                        based on the maximum value inside the profile instead
                        of a Gaussian blur translocation.
  --peak_length int     Set maximum peak length for the constant peak length.
  --max_norm_value float
                        Provide a maximum value for CV to make the normalized
                        CV plot more comparable.
  --border_penalty      Adds a penalty for non-centered peaks.
  --scale_max float     Provide a maximum value for the CV plot.
  --maxcl int           Maximal number of clusters of the kmeans clustering of
                        the peak profiles. The algorithm will be optimized,
                        i.e., the parameter is just a constraint and not
                        absolute. [Default: 15]
  -k int, --numcl int   You can forcefully set the number of cluster of peak
                        profiles.
  --sm                  Turn on the peak profile smoothing for the peak
                        profile classification. It is recommended to turn it
                        on.
  --lam float           Parameter for the peak profile classification. Set
                        lambda for the smoothing of the peak profiles. A
                        higher value (> default) will underfit. A lower value
                        (< default) will overfit. [Default: 0.3]
  --turn_off_classification
                        Turn off the peak profile classification.
```

