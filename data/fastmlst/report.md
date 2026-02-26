# fastmlst CWL Generation Report

## fastmlst

### Tool Description
fastMLST is a tool for rapid MLST typing of bacterial pathogens.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastmlst:0.0.19--pyhdfd78af_0
- **Homepage**: https://github.com/EnzoAndree/FastMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/fastmlst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastmlst/overview
- **Total Downloads**: 31.4K
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/EnzoAndree/FastMLST
- **Stars**: N/A
### Original Help Text
```text
Downloading Schemes using 20 threads:   0%|          | 0/153 [00:00<?, ?Schemes/s]
Downloading Schemes using 20 threads:   0%|          | 0/153 [00:00<?, ?Schemes/s]
Traceback (most recent call last):
  File "/usr/local/bin/fastmlst", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/bin/fastmlst.py", line 143, in main
    update_mlstdb(args.threads)
    ~~~~~~~~~~~~~^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/fastmlst/update_mlst_kit.py", line 158, in update_mlstdb
    for result in tqdm(t.imap(download_fasta, datadb.items()),
                  ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                       total=len(datadb.items()),
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^
                       desc='Downloading Schemes using {} threads'.
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                       format(threads), unit='Schemes', leave=True):
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/tqdm/std.py", line 1181, in __iter__
    for obj in iterable:
               ^^^^^^^^
  File "/usr/local/lib/python3.14/multiprocessing/pool.py", line 873, in next
    raise value
  File "/usr/local/lib/python3.14/multiprocessing/pool.py", line 125, in worker
    result = (True, func(*args, **kwds))
                    ~~~~^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/fastmlst/update_mlst_kit.py", line 139, in download_fasta
    urlretrieve(file, str(outdir) + '/' +
    ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^
                out_filename + '.txt')
                ^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/urllib/request.py", line 212, in urlretrieve
    with contextlib.closing(urlopen(url, data)) as fp:
                            ~~~~~~~^^^^^^^^^^^
  File "/usr/local/lib/python3.14/urllib/request.py", line 187, in urlopen
    return opener.open(url, data, timeout)
           ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/urllib/request.py", line 493, in open
    response = meth(req, response)
  File "/usr/local/lib/python3.14/urllib/request.py", line 602, in http_response
    response = self.parent.error(
        'http', request, response, code, msg, hdrs)
  File "/usr/local/lib/python3.14/urllib/request.py", line 531, in error
    return self._call_chain(*args)
           ~~~~~~~~~~~~~~~~^^^^^^^
  File "/usr/local/lib/python3.14/urllib/request.py", line 464, in _call_chain
    result = func(*args)
  File "/usr/local/lib/python3.14/urllib/request.py", line 611, in http_error_default
    raise HTTPError(req.full_url, code, msg, hdrs, fp)
urllib.error.HTTPError: HTTP Error 429: Too Many Requests
```

