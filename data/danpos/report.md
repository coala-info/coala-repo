# danpos CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| danpos_dpeak | PASS |  |
| danpos_dpos | PASS |  |

## Metadata
- **Skill**: generated

## danpos_dpos

### Tool Description
Analyze dynamics of nucleosome positions, including occupancy, position, and fuzziness changes.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS

### Original Help Text
```text
danpos 2.2.2  version

usage: 

python danpos.py  <command>  <path> [optional arguments]

positional arguments:
  command               set as 'dpos' to run analysis for each position.
  path                  Pairs of paths to sequencing data sets. The two paths
                        in each pair must be seperated by ':', a:b means a
                        minus b, different pairs must be seperated by ',' e.g.
                        file1.bed:dir2/,dir3/, each path could point to a file
                        or a directory containing multiple files, files under
                        each directory represent multiple replicates for the
                        same group. suggest to use .sam or .bam format for
                        input files, please read the documentation for details
                        about the other supported input formats.

optional arguments:
  -h, --help            show this help message and exit
  --------------------------         
  --- general parameters ---         
  --------------------------          
  -m , --paired         set to 1 if the input data is mate-pair (paired-end)
                        reads. Ignore this when the input is wiggle format
                        occupancy data (default: 0)
  -p , --pheight        occupancy/intensity P value cutoff for calling
                        invidual binding position (default: 0)
  -q , --height         occupancy/intensity cutoff for calling invidual
                        binding position (default: 5)
  -t , --testcut        P value cutoff for calling differential position
                        between samples (e.g. 1e-10). Set as 0 when don't need
                        to define positions based on differential P value, so
                        binding positions will then be defined only on
                        occupancy cutoff, and differential P value will be
                        calculated for each of them. (default: 0)
  -o , --out            a name for the output directory (default: result)
  -f , --fdr            set to 0 if need not to calculate FDR values (slow
                        process). (default: 1)
  -s , --save           save middle stage files? set to 0 if don't save,
                        otherwise set to 1 (default: 0)
  -b , --bg             pairs of paths, each pair secify a genomic background
                        data set for a MNase-/ChIP-Seq data set, a:b means b
                        is the background data set for a, put a word 'None'
                        when a MNase-/ChIP-Seq data set has no background data
                        set, e.g. file1.bed:bgdir1,dir2/:None,dir3/:bg3.bed,
                        this function is not recommended for MNase-Seq data
                        set. (default: None)
  --------------------------   
  ---  Position calling  --- 
  --------------------------    
  -jw , --width         the window size used for scanning for the summit of
                        each potential position. (default: 40)
  -jd , --distance      minimal center-to-center distance between positions,
                        positions closer than d will be merged as one single
                        position (default: 100)
  -jf , --position_reference 
                        map each defined position to a reference position
                        provided in the position file by this parameter.
                        (default: None)
  -R , --ratio          the ratio between the minimal occupancy flanking a
                        position and the maximal occupancy in a position, only
                        positions with values lower than this ratio will be
                        used for defining position shift events. (default:
                        0.9)
  -e , --edge           set to 1 if need to detect edges for each
                        position,else set to 0 (default: 0)
  -g , --gapfill        do gap filling? fill the gap between two neighboring
                        positions with an additional position if the gap size
                        is close to the a position size, set to 0 if don't
                        fill, otherwise set to 1 (default: 0)
  --------------------------     
  ---occupancy processing--- 
  --------------------------      
  -c , --count          specify the count of reads to be normalized to, e.g.
                        10000000. Or specify the count for each group, e.g.
                        file1.bed:10000000,dir2/:20000000,dir3/:15000000, Do
                        this only when you are clear about what you are doing,
                        e.g. when you have spike-ins to measure the real reads
                        count in each replicate (default: None)
  -a , --span           the span or step size in the generated wiggle data
                        (default: 10)
  -z , --smooth_width   the smooth width before position calling, set to 0 if
                        need not to smooth (default: 20)
  -L , --exclude_low_percent 
                        the percent of extremely low occupancy positions to be
                        excluded in determining normalization factors, may be
                        helpful to avoid the influence of background noise on
                        normalization (default: 0)
  -H , --exclude_high_percent 
                        the percent of extremely high occupancy positions to
                        be excluded in determining normalization factors, may
                        be helpful to avoid the influence of some highly
                        clonal or repeat regions on normalization. (default:
                        0)
  -l , --lmd            lambda width for smoothing background data before
                        background subtraction, ignore this when the parameter
                        -b is not specified. (default: 300)
  -n , --nor            data normalization method, could be 'F','S' or 'N',
                        representing normalization by fold change, normalize
                        by sampling, or no normalization (default: F)
  -N , --nor_region_file 
                        A '.wig' format file to denote the regions that could
                        be used to calculate normalization factors. Regions to
                        be used and not used should be assigned a value 1 and
                        0 in this .wig file, respectively. (default: None)
  --nonzero             set to 1 if want to normalize basepairs with non-zero
                        values to have the same average value between
                        different data sets. This function will be useful when
                        some data sets has severious clonal effect, E.g. one
                        data set has non-zero value at 10 percent of base
                        pairs and each non-zero vase pair has 8 fold clonal
                        effects, whereas another data set has non-zero value
                        at 40 percent of base pairs and each non-zero base
                        pair has 2 fold clonal effects. (default: 0)
  --------------------------       
  ---  reads processing  --- 
  --------------------------        
  -u , --clonalcut      the cutoff for adjusting clonal signal, set as a P
                        value larger than 0 and smaller than 1, e.g 1e-10, or
                        set as a interger reads count, set as 0 if don't need
                        to adjust clonal signal. (default: 0)
  --frsz                specify the average size of DNA fragments in the
                        seuqnecing experiment. By default it is automatically
                        detected by DANPOS. Ignore this when the input is
                        wiggle format occupancy data (default: None)
  --mifrsz              minimal size of the DNA fragments, DANPOS will select
                        a most probable frsz value within the range between
                        --mifrsz value and --mafrsz value. ignore this when '
                        --frsz' has been specified. Ignore this when the input
                        is wiggle format occupancy data (default: 50)
  --mafrsz              maximal size of the DNA fragments, DANPOS will select
                        a most probable frsz value within the range between
                        --mifrsz value and --mafrsz value. ignore this when '
                        --frsz' has been specified. Ignore this when the input
                        is wiggle format occupancy data (default: 300)
  --extend              specify the size theat each fragment will be adjusted
                        to, the size of each fragment will be adjusted to this
                        size when reads data is converted to occupancy data.
                        Ignore this when the input is wiggle format occupancy
                        data (default: 80)

Kaifu Chen, et al. chenkaifu@gmail.com, Li lab, Biostatistics department, Dan
L. Duncan cancer center, Baylor College of Medicine.
```

## danpos_dpeak

### Tool Description
Call binding peaks from MNase-/ChIP-Seq data and their changes between samples (DANPOS dpeak).

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS

### Original Help Text
```text
danpos 2.2.2  version

usage: 

python danpos.py  <command>  <path> [optional arguments]

positional arguments:
  command               set as 'dpeak' to run analysis for each dpeak.
  path                  Pairs of paths to sequencing data sets. The two paths
                        in each pair must be seperated by ':', a:b means a
                        minus b, different pairs must be seperated by ',' e.g.
                        file1.bed:dir2/,dir3/, each path could point to a file
                        or a directory containing multiple files, files under
                        each directory represent multiple replicates for the
                        same group. suggest to use .sam or .bam format for
                        input files, please read the documentation for details
                        about the other supported input formats.

optional arguments:
  -h, --help            show this help message and exit
  --------------------------         
  --- general parameters ---         
  --------------------------          
  -m , --paired         set to 1 if the input data is mate-pair (paired-end)
                        reads. Ignore this when the input is wiggle format
                        occupancy data (default: 0)
  -p , --pheight        occupancy/intensity P value cutoff for calling
                        invidual binding peak (default: 1e-10)
  -q , --height         occupancy/intensity cutoff for calling invidual
                        binding peak (default: 0)
  -t , --testcut        P value cutoff for calling differential peak between
                        samples (e.g. 1e-10). Set as 0 when don't need to
                        define peaks based on differential P value, so peaks
                        will then be defined only on occupancy cutoff, and
                        differential P value will be calculated for each of
                        them. (default: 0)
  -o , --out            a name for the output directory (default: result)
  -f , --fdr            set to 0 if need not to calculate FDR values (slow
                        process). (default: 1)
  -s , --save           save middle stage files? set to 0 if don't save,
                        otherwise set to 1 (default: 0)
  -b , --bg             pairs of paths, each pair secify a genomic background
                        data set for a MNase-/ChIP-Seq data set, a:b means b
                        is the background data set for a, put a word 'None'
                        when a MNase-/ChIP-Seq data set has no background data
                        set, e.g. file1.bed:bgdir1,dir2/:None,dir3/:bg3.bed,
                        this function is not recommended for MNase-Seq data
                        set. (default: None)
  --------------------------               
  ---    peak calling    ---               
  --------------------------             
  -kd , --peak_dis      minimal tail-to-head distance (bp) between neighboring
                        peaks, neighboring peaks closer than -D will be merged
                        as one single peak (default: 40)
  -kw , --peak_width    minimal width of each peak (default: 40)
  -kf , --peak_reference 
                        Don't call peaks, but retrive values for a set of
                        reference peaks provided in the peak file by this
                        parameter. (default: None)
  --------------------------     
  ---occupancy processing--- 
  --------------------------      
  -c , --count          specify the count of reads to be normalized to, e.g.
                        10000000. Or specify the count for each group, e.g.
                        file1.bed:10000000,dir2/:20000000,dir3/:15000000, Do
                        this only when you are clear about what you are doing,
                        e.g. when you have spike-ins to measure the real reads
                        count in each replicate (default: None)
  -a , --span           the span or step size in the generated wiggle data
                        (default: 10)
  -z , --smooth_width   the smooth width before position calling, set to 0 if
                        need not to smooth (default: 20)
  -L , --exclude_low_percent 
                        the percent of extremely low occupancy positions to be
                        excluded in determining normalization factors, may be
                        helpful to avoid the influence of background noise on
                        normalization (default: 0)
  -H , --exclude_high_percent 
                        the percent of extremely high occupancy positions to
                        be excluded in determining normalization factors, may
                        be helpful to avoid the influence of some highly
                        clonal or repeat regions on normalization. (default:
                        0)
  -l , --lmd            lambda width for smoothing background data before
                        background subtraction, ignore this when the parameter
                        -b is not specified. (default: 300)
  -n , --nor            data normalization method, could be 'F','S' or 'N',
                        representing normalization by fold change, normalize
                        by sampling, or no normalization (default: F)
  -N , --nor_region_file 
                        A '.wig' format file to denote the regions that could
                        be used to calculate normalization factors. Regions to
                        be used and not used should be assigned a value 1 and
                        0 in this .wig file, respectively. (default: None)
  --nonzero             set to 1 if want to normalize basepairs with non-zero
                        values to have the same average value between
                        different data sets. This function will be useful when
                        some data sets has severious clonal effect, E.g. one
                        data set has non-zero value at 10 percent of base
                        pairs and each non-zero vase pair has 8 fold clonal
                        effects, whereas another data set has non-zero value
                        at 40 percent of base pairs and each non-zero base
                        pair has 2 fold clonal effects. (default: 0)
  --------------------------       
  ---  reads processing  --- 
  --------------------------        
  -u , --clonalcut      the cutoff for adjusting clonal signal, set as a P
                        value larger than 0 and smaller than 1, e.g 1e-10, or
                        set as a interger reads count, set as 0 if don't need
                        to adjust clonal signal. (default: 0)
  --frsz                specify the average size of DNA fragments in the
                        seuqnecing experiment. By default it is automatically
                        detected by DANPOS. Ignore this when the input is
                        wiggle format occupancy data (default: None)
  --mifrsz              minimal size of the DNA fragments, DANPOS will select
                        a most probable frsz value within the range between
                        --mifrsz value and --mafrsz value. ignore this when '
                        --frsz' has been specified. Ignore this when the input
                        is wiggle format occupancy data (default: 50)
  --mafrsz              maximal size of the DNA fragments, DANPOS will select
                        a most probable frsz value within the range between
                        --mifrsz value and --mafrsz value. ignore this when '
                        --frsz' has been specified. Ignore this when the input
                        is wiggle format occupancy data (default: 300)
  --extend              specify the size theat each fragment will be adjusted
                        to, the size of each fragment will be adjusted to this
                        size when reads data is converted to occupancy data.
                        Ignore this when the input is wiggle format occupancy
                        data (default: 80)

Kaifu Chen, et al. chenkaifu@gmail.com, Li lab, Biostatistics department, Dan
L. Duncan cancer center, Baylor College of Medicine.
```
