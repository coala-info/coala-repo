# epimuller CWL Generation Report

## epimuller

### Tool Description
epimuller

### Metadata
- **Docker Image**: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
- **Homepage**: https://github.com/jennifer-bio/epimuller
- **Package**: https://anaconda.org/channels/bioconda/packages/epimuller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/epimuller/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jennifer-bio/epimuller
- **Stars**: N/A
### Original Help Text
```text
Loaded imports
usage: epimuller [-h] [-oDir OUTDIRECTORY] -oP OUTPREFIX
                 (-n INNEXTSTRAIN | -a ANNOTATEDTREE) -m INMETA
                 [-p INPANGOLIN] [--noPangolin] [-k TRAITOFINTERSTKEY]
                 [-f TRAITOFINTERSTFILE] [-g GENEBOUNDRY]
                 [-mut VOCLIST [VOCLIST ...]] [-t TIMEWINDOW] [-s STARTDATE]
                 [-e ENDDATE] [-mt MINTIME] [-min MINTOTALCOUNT]
                 [-c CASES_NAME] [--avgWindow AVGWINDOW]
                 [-l {date,time,bimonthly}] [-lp {Right,Max,Start,End}]
                 [--WIDTH WIDTH] [--HEIGHT HEIGHT] [--LEGENDWIDTH LEGENDWIDTH]
                 [--MARGIN MARGIN] [--FONTSIZE FONTSIZE]
                 [--LABELSHIFT LABELSHIFT]

optional arguments:
  -h, --help            show this help message and exit
  -n INNEXTSTRAIN, --inNextstrain INNEXTSTRAIN
                        nextstrain results with tree.nwk and
                        [traitOfInterst].json (default: None)
  -a ANNOTATEDTREE, --annotatedTree ANNOTATEDTREE
                        nexus file name with annotation:
                        [&!traitOfInterst=value], as output by treetime
                        (default: None)

Options for full repot:
  -oDir OUTDIRECTORY, --outDirectory OUTDIRECTORY
                        folder for output (default: ./)
  -oP OUTPREFIX, --outPrefix OUTPREFIX
                        prefix of out files withen outDirectory (default:
                        None)

Options passed to epimuller-define:
  -m INMETA, --inMeta INMETA
                        metadata tsv with 'strain' and 'date'cols, optional:
                        cols of trait of interst; and pangolin col
                        named:'pangolin_lineage', 'lineage' or 'pangolin_lin'
                        (default: None)
  -p INPANGOLIN, --inPangolin INPANGOLIN
                        pangolin output lineage_report.csv file, if argument
                        not supplied looks in inMeta for col with
                        'pangolin_lineage', 'pangolin_lin', or 'lineage'
                        (default: metadata)
  --noPangolin          do not add lineage to clade names (default: False)
  -k TRAITOFINTERSTKEY, --traitOfInterstKey TRAITOFINTERSTKEY
                        key for trait of interst in json file OR (if
                        -a/--annotatedTree AND key is mutations with aa (not
                        nuc): use 'aa_muts') (default: aa_muts)
  -f TRAITOFINTERSTFILE, --traitOfInterstFile TRAITOFINTERSTFILE
                        [use with -n/--inNextstrain] name of
                        [traitOfInterstFile].json in '-n/--inNextstrain'
                        folder (default: aa_muts.json)
  -g GENEBOUNDRY, --geneBoundry GENEBOUNDRY
                        [use with -a/--annotatedTree AND -k/--traitOfInterst
                        aa_muts] json formated file specifing start end
                        postions of genes in alignment for annotatedTree (see
                        example data/geneAAboundries.json) (default: None)
  -mut VOCLIST [VOCLIST ...], --VOClist VOCLIST [VOCLIST ...]
                        list of aa of interest in form
                        [GENE][*ORAncAA][site][*ORtoAA] ex. S*501*, gaps
                        represed by X, wild card aa represented by * (default:
                        None)
  -t TIMEWINDOW, --timeWindow TIMEWINDOW
                        number of days for sampling window (default: 7)
  -s STARTDATE, --startDate STARTDATE
                        start date in iso format YYYY-MM-DD or 'firstDate'
                        which sets start date to first date in metadata
                        (default: 2020-03-01)
  -e ENDDATE, --endDate ENDDATE
                        end date in iso format YYYY-MM-DD or 'lastDate' which
                        sets end date as last date in metadata (default:
                        lastDate)

Options passed to epimuller-draw:
  -mt MINTIME, --MINTIME MINTIME
                        minimum time point to start plotting (default: 30)
  -min MINTOTALCOUNT, --MINTOTALCOUNT MINTOTALCOUNT
                        minimum total count for group to be included (default:
                        50)
  -c CASES_NAME, --cases_name CASES_NAME
                        file with cases - formated with 'date' in ISO format
                        and 'confirmed_rolling' cases, in tsv format (default:
                        None)
  --avgWindow AVGWINDOW
                        width of rolling mean window in terms of
                        --timeWindow's (recomend using with small
                        --timeWindow) ; default: sum of counts withen
                        timeWindow (ie no average) (default: None)
  -l {date,time,bimonthly}, --xlabel {date,time,bimonthly}
                        Format of x axis label: ISO date format or timepoints
                        from start, or dd-Mon-YYYY on 1st and 15th (default:
                        date)
  -lp {Right,Max,Start,End}, --labelPosition {Right,Max,Start,End}
                        choose position of clade labels (default: Right)

Options passed to epimuller-draw for page setup:
  --WIDTH WIDTH         WIDTH of page (px) (default: 1500)
  --HEIGHT HEIGHT       HEIGHT of page (px) (default: 1000)
  --LEGENDWIDTH LEGENDWIDTH
                        LEGENDWIDTH to the right of plotting area (px)
                        (default: 220)
  --MARGIN MARGIN       MARGIN around all sides of plotting area (px)
                        (default: 60)
  --FONTSIZE FONTSIZE
  --LABELSHIFT LABELSHIFT
                        nudge label over by LABELSHIFT (px) (default: 15)
```

