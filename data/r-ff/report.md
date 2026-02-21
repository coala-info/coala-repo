# ff: Memory-Efficient Storage of Large Data on Disk and Fast Access
Functions

The ff package provides data structures that are stored on
	disk but behave (almost) as if they were in RAM by transparently 
	mapping only a section (pagesize) in main memory - the effective 
	virtual memory consumption per ff object. ff supports R's standard 
	atomic data types 'double', 'logical', 'raw' and 'integer' and 
	non-standard atomic types boolean (1 bit), quad (2 bit unsigned), 
	nibble (4 bit unsigned), byte (1 byte signed with NAs), ubyte (1 byte 
	unsigned), short (2 byte signed ...

### Metadata
- **Conda (r channel)**: https://anaconda.org/r/r-ff
- **R-project (CRAN)**: https://cloud.r-project.org/web/packages/ff/index.html
- **Home (project)**: http://ff.r-forge.r-project.org/
- **Package**: ff
- **Version**: 4.5.2
- **Author**: Daniel Adler [aut], Christian Gläser [ctb], Oleg Nenadic [ctb], Jens Oehlschlägel [aut, cre], Martijn Schuemie [ctb], Walter Zucchini [ctb]
- **Maintainer**: Jens Oehlschlägel <Jens.Oehlschlaegel at truecluster.com>
- **Skill**: generated

