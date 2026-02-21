# argnorm CWL Generation Report

## argnorm_argsoap

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/BigDataBiology/argNorm
- **Stars**: N/A
### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## argnorm_abricate

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## argnorm_deeparg

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## argnorm_resfinder

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## argnorm_amrfinderplus

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## argnorm_groot

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## argnorm_hamronization

### Tool Description
argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

### Metadata
- **Docker Image**: quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/argNorm
- **Package**: https://anaconda.org/channels/bioconda/packages/argnorm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: argnorm [-h] [--version]
               [--db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}]
               [-i INPUT] [--hamronization_skip_unsupported_tool] [-o OUTPUT]
               {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}

argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology).

positional arguments:
  {argsoap,abricate,deeparg,resfinder,amrfinderplus,groot,hamronization}
                        tool (required): The bioinformatics tool used for ARG
                        annotation.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --db {argannot,deeparg,megares,ncbi,resfinder,resfinderfg,sarg,groot-db,groot-core-db,groot-argannot,groot-resfinder,groot-card}
                        --db (mostly optional): The database used alongside
                        the ARG annotation tool. This is only required if
                        abricate or groot is used as a tool. Please refer here
                        for more information on --db:
                        https://github.com/BigDataBiology/argNorm?tab=readme-
                        ov-file#--db-optional
  -i, --input INPUT     -i (required): The path to the ARG annotation result
                        which needs to be normalized.
  --hamronization_skip_unsupported_tool
                        --hamronization_skip_unsupported_tool (optional): skip
                        rows with unsupported tools for hamronization outputs.
                        argNorm be default will raise an exception if
                        unsupported tool is found in hamronization. Use this
                        if you only want argNorm to raise a warning.
  -o, --output OUTPUT   -o (required): The path to the output file where you
                        would like to store argNorm's results

If argNorm is helpful in a scientific publication, please cite:

    argNorm: normalization of antibiotic resistance gene annotations to the Antibiotic Resistance Ontology (ARO)
    by Svetlana Ugarcina Perovic, Vedanth Ramji, Hui Chong, Yiqian Duan, Finlay Maguire, Luis Pedro Coelho
    in Bioinformatics (2025) https://doi.org/10.1093/bioinformatics/btaf173
```


## Metadata
- **Skill**: generated
