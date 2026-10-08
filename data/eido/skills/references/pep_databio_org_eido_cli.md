Source: https://pep.databio.org/eido/code/cli/ (docs/code/cli.md)

# `eido` command line usage

To use the command line application one just needs a path to a project configuration file. It is a positional argument in the `eido` command.

For this tutorial, let's grab a PEP from a public example repository that describes a few PRO-seq test samples:


```bash
rm -rf ppqc
git clone https://github.com/databio/ppqc.git --branch cfg2
```

    Cloning into 'ppqc'...
    remote: Enumerating objects: 154, done.
    remote: Counting objects: 100% (20/20), done.
    remote: Compressing objects: 100% (15/15), done.
    remote: Total 154 (delta 7), reused 17 (delta 5), pack-reused 134
    Receiving objects: 100% (154/154), 81.69 KiB | 3.27 MiB/s, done.
    Resolving deltas: 100% (82/82), done.



```bash
cd ppqc
export DATA=$HOME
export SRAFQ=$HOME
```

## PEP inspection

First, let's use `eido inspect` to inspect a PEP. 

 - To inspect the entire `Project` object just provide the path to the project configuration file.


```bash
eido inspect peppro_paper.yaml
```

    Project 'PEPPRO' (peppro_paper.yaml)
    47 samples (showing first 20): K562_PRO-seq_02, K562_PRO-seq_04, K562_PRO-seq_06, K562_PRO-seq_08, K562_PRO-seq_10, K562_PRO-seq_20, K562_PRO-seq_30, K562_PRO-seq_40, K562_PRO-seq_50, K562_PRO-seq_60, K562_PRO-seq_70, K562_PRO-seq_80, K562_PRO-seq_90, K562_PRO-seq_100, K562_RNA-seq_0, K562_RNA-seq_10, K562_RNA-seq_20, K562_RNA-seq_30, K562_RNA-seq_40, K562_RNA-seq_50
    Sections: name, pep_version, sample_table, looper, sample_modifiers


 - To inspect a specific sample, one needs to provide the sample name (via `-n`/`--sample-name` optional argument)


```bash
eido inspect peppro_paper.yaml -n K562_PRO-seq K562_RNA-seq_10
```

    Sample 'K562_RNA-seq_10' in Project (peppro_paper.yaml)
    
    sample_name:         K562_RNA-seq_10
    sample_desc:         90% K562 PRO-seq + 10% K562 RNA-seq
    treatment:           70M total reads
    protocol:            PRO
    organism:            human
    read_type:           SINGLE
    umi_len:             0
    read1:               /Users/mstolarczyk/K562_10pctRNA.fastq.gz
    srr:                 K562_10pctRNA
    pipeline_interfaces: $CODE/peppro/sample_pipeline_interface.yaml
    genome:              hg38
    
    ...                (showing first 10)
    
    


## PEP validation

Next, let's use `eido` to validate this project against the generic PEP schema. You just need to provide a path to the project config file and schema as an input.


```bash
eido validate peppro_paper.yaml -s http://schema.databio.org/pep/2.0.0.yaml -e
```

    Validation successful


Any PEP should validate against that schema, which describes generic PEP format. We can go one step further and validate it against the PEPPRO schema, which describes Proseq projects specifically for this pipeline:


```bash
eido validate peppro_paper.yaml -s http://schema.databio.org/pipelines/ProseqPEP.yaml
```

    Validation successful


This project would *not* validate against a different pipeline's schema.

Following `jsonschema`, `eido` produces comprehensive error messages that include the objects that did not pass validation. When validating PEPs that include lots of samples one can use option `-e`/`--exclude-case` to limit the error output just to the human readable message. This is the option used in the example below:


```bash
eido validate peppro_paper.yaml -s http://schema.databio.org/pipelines/bedmaker.yaml -e
```

    Traceback (most recent call last):
      File "/usr/local/bin/eido", line 8, in <module>
        sys.exit(main())
      File "/usr/local/lib/python3.9/site-packages/eido/cli.py", line 89, in main
        validate_project(p, args.schema, args.exclude_case)
      File "/usr/local/lib/python3.9/site-packages/eido/validation.py", line 45, in validate_project
        _validate_object(project_dict, preprocess_schema(schema_dict), exclude_case)
      File "/usr/local/lib/python3.9/site-packages/eido/validation.py", line 30, in _validate_object
        raise jsonschema.exceptions.ValidationError(e.message)
    jsonschema.exceptions.ValidationError: 'input_file_path' is a required property




Optionally, to validate just the config part of the PEP or a specific sample, `-n`/`--sample-name` or `-c`/`--just-config` arguments should be used, respectively. Please refer to the help for more details:


```bash
eido validate -h
```

    usage: eido validate [-h] -s S [-e] [-n S | -c] PEP
    
    Validate the PEP or its components.
    
    positional arguments:
      PEP                   Path to a PEP configuration file in yaml format.
    
    optional arguments:
      -h, --help            show this help message and exit
      -s S, --schema S      Path to a PEP schema file in yaml format.
      -e, --exclude-case    Whether to exclude the validation case from an error.
                            Only the human readable message explaining the error
                            will be raised. Useful when validating large PEPs.
      -n S, --sample-name S
                            Name or index of the sample to validate. Only this
                            sample will be validated.
      -c, --just-config     Whether samples should be excluded from the
                            validation.


## PEP conversion

Let's use `eido convert` command to convert PEPs to a variety of different formats. `eido` supports a plugin system, which can be used by other tool developers to create Python plugin functions that save PEPs in a desired format. Please refer to the documentation for more details. For now let's focus on a couple of plugins that are built-in in `eido`.

To see what plugins are currently available in your Python environment call:


```bash
eido filters
```

    Available filters:
     - basic
     - csv
     - yaml
     - yaml-samples



```bash
eido convert peppro_paper.yaml --format basic
```

    Running plugin basic
    Project 'PEPPRO' (peppro_paper.yaml)
    47 samples (showing first 20): K562_PRO-seq_02, K562_PRO-seq_04, K562_PRO-seq_06, K562_PRO-seq_08, K562_PRO-seq_10, K562_PRO-seq_20, K562_PRO-seq_30, K562_PRO-seq_40, K562_PRO-seq_50, K562_PRO-seq_60, K562_PRO-seq_70, K562_PRO-seq_80, K562_PRO-seq_90, K562_PRO-seq_100, K562_RNA-seq_0, K562_RNA-seq_10, K562_RNA-seq_20, K562_RNA-seq_30, K562_RNA-seq_40, K562_RNA-seq_50
    Sections: name, pep_version, sample_table, looper, sample_modifiers



```bash
eido convert peppro_paper.yaml --format csv
```

    Running plugin csv
    sample_name,genome,organism,pipeline_interfaces,prealignments,protocol,read1,read_type,sample_desc,sample_name,srr,treatment,umi_len,read2
    K562_PRO-seq_02,hg38,human,...
    ... (one line per sample; output trimmed)
