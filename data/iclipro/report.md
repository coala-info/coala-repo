# iclipro CWL Generation Report

## iclipro_iCLIPro

### Tool Description
For given input BAM file [in.bam] the script will generate a number of output files that can be used to check for and diagnose systematic misassignments in iCLIP data.

### Metadata
- **Docker Image**: quay.io/biocontainers/iclipro:0.1.1--py27_0
- **Homepage**: http://www.biolab.si/iCLIPro/doc/
- **Package**: https://anaconda.org/channels/bioconda/packages/iclipro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iclipro/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
iCLIPro usage
=============

Usage: iCLIPro [options] in.bam

Options:
    -o FOLDER  output folder (default is cwd - current working directory)
    -b INT     genomic bin size (100..1000, default: 300)
    -r INT     number of reads required in bin (20..500, default: 50)
    -s INT     flanking distances when calculating start site overlap ratio (3..15, default: 5)
    -q INT     use only reads with minimum mapping quality (mapq) (0..100, default: 10)
    -g LIST    read len groups (e.g.: "A:16-39,A1:16-25,A2:26-32,A3:33-39,L:20,B:42")
    -p LIST    generate read overlap maps based on these

               comparisons (e.g.: "A1-A3,A2-A3,A1-B,A2-B,A3-B,L-B,A-B")
    -f INT     flanking region for read overlap maps (default: 50)
    -h         longer help

For given input BAM file [in.bam] the script will generate
a number of output files that can be used to check for and diagnose
systematic misassignments in iCLIP data.

Main result is stored in file [in_report.txt], for given [in.bam] BAM file.

Read (query template) names in BAM files should include a record
of form expressed with this regular expression: ``:rbc[ATCGN]+:``.
The ending colon can be omitted if random barcode record is placed
at the end of the name. Some valid examples::

   D3FCO8P1:206:C2M53ACXX:8:1207:17086:80291:1:N:0:rbcTGTAC: 272     1       11861 ... 
   D3FCO8P1:206:C2M53ACXX:8:1101:6625:73240:1:N:0:rbcCCGCC   16      1       11976 ...
   D3FCO8P1:206:C2M53ACXX:8:1203:17298:81179:rbcCCGCC:1:N:0  16      1       11976 ...

Random barcodes can be specified at the end of the name but
must be preceded by colon, for example::

   D3FCO8P1:206:C2M53ACXX:8:1207:17086:80291:1:N:0:TGTAC     272     1       11861 ... 
   D3FCO8P1:206:C2M53ACXX:8:1101:6625:73240:1:N:0   :CCGCC   16      1       11976 ...
   D3FCO8P1:206:C2M53ACXX:8:1203:17298:81179:1:N:0 :CCGCC    16      1       11976 ...

If no random barcode information is available, then iCLIPro will
most likely be able to work with the original read names. In such
case, please check that the read names do not include any text
that conforms to the rules for specifying random barcode as it
may mislead iCLIPro.

The generated report file includes a list of random barcodes
identified by iCLIPro. You should check it first and make sure
that proper random barcode information is being used.

Parameters -b and -r:
  Specifies the bin size to use when segmenting the genome.
  Only bins with enough reads (parameter -r) are then considered
  in the read overlap testing.

Parameter -s:
  Flanking region when calculating the mean and the median start
  site overlap ratios.

Parameter -q:
  Consider only reads that pass the minimum mapping quality,
  ignore the rest.

Parameter -g:
  iCLIPro needs to group reads based on their length.
  Any number of (overlapping) groups can be specified. For each
  group, an interval (INT1-INT2) or single value (INT) of the
  read lengths in the group can be specified.

Parameter -p (read overlap maps):
  Specifies which groups of reads to compare. When performing a
  comparison (G1-G2), cross-linked sites identified based on
  group G2 are used as reference (zero position). The relative
  positioning of sites identified in G1 is the computed and
  shown in read overlap maps.

Parameter -f:
  Width of the flanking region relative to reference point
  shown in read overlap maps.


Method
^^^^^^

A typical (i)CLIP experiment may result in the detection of RNA
fragments of different lengths. Under the assumptions of
conventional iCLIP, the start sites of iCLIP fragments should
coincide at the cross-linking position in a fragment
length-independent fashion.

This interpretation may not hold for some iCLIP libraries (e.g.,
substantial read-through, binding to long RNA stretches etc). For
details, see associated paper by Hauer and coauthors. In summary,
we identified a previously unrecognized effect of iCLIP fragment
length on the position of fragment start sites and thus assigned
binding sites for some RBPs.

iCLIPro is a robust analysis approach that examines this effect
and thus can improve the assignment of binding sites from iCLIP
data.

iCLIPro's main function is to visualize coinciding and
non-coinciding fragment start sites in order to examine the best
way how to analyze iCLIP data.

With iCLIPro you can test test and compare the overlap of
different reference points in the iCLIP fragments:
   * one nucleotide before first mapped nucleotide (conventional assumption)
   * center of the read
   * end of the read

iCLIPro identifies regions (bins in genome, parameter -b) with a
sufficient number of reads (parameter -r) for an read overlap
test. Reads from each selected bin are processed separately.
Reads get grouped based on their length (parameter -g) and sites
from different groups are compared.

The main output of iCLIPro are read overlap heatmaps that
identify the best mode of analysis.


Read overlap heatmaps
^^^^^^^^^^^^^^^^^^^^^

Read overlap maps are generated by comparing fragment start,
center and end sites in the *test* and *reference* groups.

The data underlying the high-resolution overlap heatmaps is
used to calculate a ratio of overlapping and non-overlapping
start sites thus enabling the decision to be made as to whether
the start or the center of the fragments should be used as a
reference point for most accurately defining the binding site.
This overlap start site ratio is reported at the end of the
generated report file. When calculating the start site overlap
ratio a default flanking distance of 5 nt is used
(parameter -s, see paper).

A ratio well above 1 suggests to use the start sites of iCLIP
fragments to detect binding sites (e.g., mean overlap start
site ratio of 1.31 for U2AF65). A ratio below 1 favors the
use of the center position for binding site assignment
(e.g., mean overlap start site ratio of 0.88 for eIF4A3,
see paper for details).

Sites identified based on a reference group are used to define 
the reference (zero) position in the map. The regions (-50 to +50, 
x-axis on plots, parameter -f) relative to the reference positions
are then scanned and number of co-occuring sites in test group is recorded.

The x-axis shows the offset of the sites of the test group
(shorter reads) relative to the sites of the reference group
(usually longer reads). The y-axis shows the fragment length.
The color in the heatmap represents the number of fragments
that co-occur at a given offset relative to the longer reference
fragments. 

In case of the fragment start sites, a peak at the start reference
position 0 corresponds to coinciding start sites, whereas a
distribution downstream of the reference position 0 arises from
start sites of smaller fragments that occur at length-dependent
offsets from the reference start sites.
```


## iclipro_iCLIPro_bam_splitter

### Tool Description
BAM splitter

### Metadata
- **Docker Image**: quay.io/biocontainers/iclipro:0.1.1--py27_0
- **Homepage**: http://www.biolab.si/iCLIPro/doc/
- **Package**: https://anaconda.org/channels/bioconda/packages/iclipro/overview
- **Validation**: PASS

### Original Help Text
```text
BAM splitter
^^^^^^^^^^^^

Usage: iCLIPro_bam_splitter [options] <in1.bam>

Options:
    -o FOLDER  output folder (default is cwd - current working directory)
    -q INT     use only reads with minimum mapping quality (mapq) (0..100, default: 10)
    -g LIST    read len groups (default: "A:16-39,A1:16-25,A2:26-32,A3:33-39,B:42")
    -h         longer help

For given input BAM file [in.bam] the script will generate
an output bam file for each read group.

Reads get grouped based on their length (parameter -g). Each
group of reads is used to generate three bedGraphs files
with the following reference positions:
  * one nucleotide before first mapped nucleotide
  * center of the read
  * end of the read

Read (query template) names in BAM file should include a record
of form expressed with this regular expression: ``:rbc[ATCGN]+:``.
The ending colon can be omitted if random barcode record is placed
at the end of the name. Some valid examples::

   D3FCO8P1:206:C2M53ACXX:8:1207:17086:80291:1:N:0:rbcTGTAC: 272     1       11861 ... 
   D3FCO8P1:206:C2M53ACXX:8:1101:6625:73240:1:N:0:rbcCCGCC   16      1       11976 ...
   D3FCO8P1:206:C2M53ACXX:8:1203:17298:81179:rbcCCGCC:1:N:0  16      1       11976 ...

Random barcodes can be specified at the end of the name but
must be preceded by colon, for example::

   D3FCO8P1:206:C2M53ACXX:8:1207:17086:80291:1:N:0:TGTAC     272     1       11861 ... 
   D3FCO8P1:206:C2M53ACXX:8:1101:6625:73240:1:N:0   :CCGCC   16      1       11976 ...
   D3FCO8P1:206:C2M53ACXX:8:1203:17298:81179:1:N:0 :CCGCC    16      1       11976 ...

If no random barcode information is available, then the script will
most likely be able to work with the original read names. In such
case, please check that the read names do not include any text
that conforms to the rules for specifying random barcode as it
may mislead the script.

The script outputs a list of identified random barcodes.
You should check the list to make sure that proper random barcode
information is being used.

Parameter -q:
  Consider only reads that pass the minimum mapping quality,
  ignore the rest.

Parameter -g:
  iCLIPro needs to group reads based on their length.
  Any number of (overlapping) groups can be specified. For each
  group, an interval (INT1-INT2) or single value (INT) of the
  read lengths in the group can be specified.
```


## Metadata
- **Skill**: generated
