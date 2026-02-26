# seqsero CWL Generation Report

## seqsero

### Tool Description
SeqSero: a bioinformatics tool for serotype prediction of Salmonella enterica

### Metadata
- **Docker Image**: biocontainers/seqsero:v1.0.1dfsg-1-deb_cv1
- **Homepage**: https://github.com/denglab/SeqSero2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqsero/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/denglab/SeqSero2
- **Stars**: N/A
### Original Help Text
```text
usage: seqsero -m <data_type> -i <input_data> [-b <BWA_algorithm>]

Developer: Shaokang Zhang (zskzsk@uga.edu) and Xiangyu Deng (xdeng@uga.edu)

Contact email:seqsero@gmail.com

optional arguments:
  -h, --help            show this help message and exit
  -m {1,2,3,4}          <int>: '1'(pair-end reads, interleaved),'2'(pair-end
                        reads, seperated),'3'(single-end reads), '4'(assembly)
  -i I [I ...]          <string>: path/to/input_data
  -b {sam,mem,nanopore}
                        <string>: 'sam'(bwa samse/sampe), 'mem'(bwa mem),
                        default=sam
  -d D                  <string>: output directory name, if not set, the
                        output directory would be 'SeqSero_result_'+time
                        stamp+one random number
```

