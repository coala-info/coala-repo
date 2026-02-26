# alter-sequence-alignment CWL Generation Report

## alter-sequence-alignment

### Tool Description
A tool for converting and manipulating sequence alignment files, including collapsing sequences to haplotypes.

### Metadata
- **Docker Image**: biocontainers/alter-sequence-alignment:v1.3.4-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alter-sequence-alignment/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
"--help" is not a valid option
 -c (--collapse)              : Collapse sequences to haplotypes. (default:
                                false)
 -cg (--collapseGaps)         : Treat gaps as missing data when collapsing.
                                (default: false)
 -cl (--collapseLimit) N      : Connection limit (sequences differing at <= l
                                sites will be collapsed) (default is l=0).
                                (default: 0)
 -cm (--collapseMissing)      : Count missing data as differences when
                                collapsing. (default: true)
 -i (--input) FILE            : Input file.
 -ia (--inputAutodetect)      : Autodetect format (other input options are
                                omitted). (default: false)
 -if (--inputFormat) VAL      : Input format (ALN, FASTA, GDE, MEGA, MSF,
                                NEXUS, PHYLIP or PIR).
 -io (--inputOS) VAL          : Input operating system (Linux, MacOS or
                                Windows).
 -ip (--inputProgram) VAL     : Input program (Clustal, MAFFT, MUSCLE, PROBCONS
                                or TCoffee).
 -o (--output) FILE           : Output file.
 -of (--outputFormat) VAL     : Output format (ALN, FASTA, GDE, MEGA, MSF,
                                NEXUS, PHYLIP or PIR).
 -ol (--outputLowerCase)      : Lowe case output. (default: false)
 -om (--outputMatch)          : Output match characters. (default: false)
 -on (--outputResidueNumbers) : Output residue numbers (only ALN format).
                                (default: false)
 -oo (--outputOS) VAL         : Output operating system (Linux, MacOS or
                                Windows).
 -op (--outputProgram) VAL    : Output program (jModelTest, MrBayes, PAML,
                                PAUP, PhyML, ProtTest, RAxML, TCS, CodABC,
                                BioEdit, MEGA, dnaSP, Se-Al, Mesquite,
                                SplitsTree, Clustal, MAFFT, MUSCLE, PROBCONS,
                                TCoffee, Gblocks, SeaView, trimAl or GENERAL)
 -os (--outputSequential)     : Sequential output (only NEXUS and PHYLIP
                                formats). (default: false)
```


## Metadata
- **Skill**: not generated
