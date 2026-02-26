# rtk2 CWL Generation Report

## rtk2_rarefaction

### Tool Description
rarefaction tool kit (rtk)

### Metadata
- **Docker Image**: quay.io/biocontainers/rtk2:2.11.2--h077b44d_1
- **Homepage**: https://github.com/hildebra/rtk2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rtk2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rtk2/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hildebra/rtk2
- **Stars**: N/A
### Original Help Text
```text
rarefaction tool kit (rtk) 2.12

USAGE
    rtk <mode> -i <input.csv> -o <output> [options] 

MODE rarefaction

OPTIONS
<mode>      For rarefaction: mode can be either swap or memory.
            Swap mode creates temporary files but uses less memory. 
            The speed of both modes is comparable.
    -i      path to an .txt file (tab delimited) to rarefy
    -o      path to a output directory
    -d      Depth or multiple comma seperated depths to rarefy to. Default is 0.95 times the minimal column sum.
    -r      Number of times to create diversity measures. Default is 10.
    -w      Number of rarefied tables to write.
    -t      Number of threads to use. Default: 1
    -ns     If set, no temporary files will be used when writing rarefaction tables to disk.

EXAMPLE
    Rarefy a table to 1000 counts per sample with two threads. Create one table:
        rtk swap -i table.csv -o outputdir/prefix. -d 1000 -r 10 -w 1 -t 2

    Rarefy with most memory and least amount of IO:
        rtk memory -i table.csv -o outputdir/prefix. -ns

MODE: Colsums
Reports the column sums of all columns in form of a sorted and an unsorted file.

EXAMPLE
    Repot column sums of file 'table.csv'
        rtk colsums -i table.csv -o prefix
```


## rtk2_colsums

### Tool Description
Reports the column sums of all columns in form of a sorted and an unsorted file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtk2:2.11.2--h077b44d_1
- **Homepage**: https://github.com/hildebra/rtk2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rtk2/overview
- **Validation**: PASS

### Original Help Text
```text
rarefaction tool kit (rtk) 2.12

USAGE
    rtk <mode> -i <input.csv> -o <output> [options] 

MODE rarefaction

OPTIONS
<mode>      For rarefaction: mode can be either swap or memory.
            Swap mode creates temporary files but uses less memory. 
            The speed of both modes is comparable.
    -i      path to an .txt file (tab delimited) to rarefy
    -o      path to a output directory
    -d      Depth or multiple comma seperated depths to rarefy to. Default is 0.95 times the minimal column sum.
    -r      Number of times to create diversity measures. Default is 10.
    -w      Number of rarefied tables to write.
    -t      Number of threads to use. Default: 1
    -ns     If set, no temporary files will be used when writing rarefaction tables to disk.

EXAMPLE
    Rarefy a table to 1000 counts per sample with two threads. Create one table:
        rtk swap -i table.csv -o outputdir/prefix. -d 1000 -r 10 -w 1 -t 2

    Rarefy with most memory and least amount of IO:
        rtk memory -i table.csv -o outputdir/prefix. -ns

MODE: Colsums
Reports the column sums of all columns in form of a sorted and an unsorted file.

EXAMPLE
    Repot column sums of file 'table.csv'
        rtk colsums -i table.csv -o prefix
```

