# cap3 CWL Generation Report

## cap3

### Tool Description
CAP3 is a DNA sequence assembly program for small-scale assembly projects.

### Metadata
- **Docker Image**: quay.io/biocontainers/cap3:10.2011--1
- **Homepage**: https://github.com/crockwell/Cap3D
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cap3/overview
- **Total Downloads**: 15.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/crockwell/Cap3D
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
VersionDate: 02/10/15  Size of long: 8
Usage: /usr/local/bin/cap3 File_of_reads [options]

File_of_reads is a file of DNA reads in FASTA format

If the file of reads is named 'xyz', then
the file of quality values must be named 'xyz.qual',
and the file of constraints named 'xyz.con'.
Options (default values):
  -a  N  specify band expansion size N > 10 (20)
  -b  N  specify base quality cutoff for differences N > 15 (20)
  -c  N  specify base quality cutoff for clipping N > 5 (12)
  -d  N  specify max qscore sum at differences N > 20 (200)
  -e  N  specify clearance between no. of diff N > 10 (30)
  -f  N  specify max gap length in any overlap N > 1 (20)
  -g  N  specify gap penalty factor N > 0 (6)
  -h  N  specify max overhang percent length N > 2 (20)
  -i  N  specify segment pair score cutoff N > 20 (40)
  -j  N  specify chain score cutoff N > 30 (80)
  -k  N  specify end clipping flag N >= 0 (1)
  -m  N  specify match score factor N > 0 (2)
  -n  N  specify mismatch score factor N < 0 (-5)
  -o  N  specify overlap length cutoff > 15 (40)
  -p  N  specify overlap percent identity cutoff N > 65 (90)
  -r  N  specify reverse orientation value N >= 0 (1)
  -s  N  specify overlap similarity score cutoff N > 250 (900)
  -t  N  specify max number of word matches N > 30 (300)
  -u  N  specify min number of constraints for correction N > 0 (3)
  -v  N  specify min number of constraints for linking N > 0 (2)
  -w  N  specify file name for clipping information (none)
  -x  N  specify prefix string for output file names (cap)
  -y  N  specify clipping range N > 5 (100)
  -z  N  specify min no. of good reads at clip pos N > 0 (3)
```


## Metadata
- **Skill**: not generated
