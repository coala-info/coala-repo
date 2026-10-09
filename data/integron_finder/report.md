# integron_finder CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| integron_finder | Failed | image problem: integron_finder stops at start with an ImportError because pandas 0.24.2 needs numpy 1.12 or newer but the image has numpy 1.11.0 |

## integron_finder

### Tool Description
Finds integrons in a given genome sequence.

### Metadata
- **Docker Image**: biocontainers/integron-finder:v1.5.1_cv2
- **Homepage**: https://github.com/gem-pasteur/Integron_Finder
- **Package**: https://anaconda.org/channels/bioconda/packages/integron_finder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/integron_finder/overview
- **Total Downloads**: 15.4K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/gem-pasteur/Integron_Finder
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'biocontainers/integron-finder:v1.5.1_cv2' locally
v1.5.1_cv2: Pulling from biocontainers/integron-finder
9ff7e2e5f967: Pulling fs layer
59856638ac9f: Pulling fs layer
6f317d6d954b: Pulling fs layer
a9dde5e2a643: Pulling fs layer
47ce52e5fcaa: Pulling fs layer
22e082fd1f08: Pulling fs layer
a119bff55ec6: Pulling fs layer
6f317d6d954b: Waiting
a9dde5e2a643: Waiting
47ce52e5fcaa: Waiting
22e082fd1f08: Waiting
a119bff55ec6: Waiting
docker: write /var/lib/docker/tmp/GetImageBlob3579949033: no space left on device

Run 'docker run --help' for more information
```

