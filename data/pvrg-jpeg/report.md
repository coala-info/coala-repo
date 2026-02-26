# pvrg-jpeg CWL Generation Report

## pvrg-jpeg

### Tool Description
PVRG JPEG codec for encoding and decoding images

### Metadata
- **Docker Image**: biocontainers/pvrg-jpeg:v1.2.1dfsg1-6-deb_cv1
- **Homepage**: https://github.com/deepin-community/pvrg-jpeg
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pvrg-jpeg/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/deepin-community/pvrg-jpeg
- **Stars**: N/A
### Original Help Text
```text
jpeg -iw ImageWidth -ih ImageHeight [-JFIF] [-q(l) Q-Factor]
     [-a] [-b] [-d] [-k predictortype] [-n] [-O] [-y] [-z] [-g]
     [-p PrecisionValue] [-t pointtransform]
     [-r ResyncInterval] [-s StreamName] [-o OutBaseName]
     [[-ci ComponentIndex1] [-fw FrameWidth1] [-fh FrameHeight1]
      [-hf HorizontalFrequency1] [-vf VerticalFrequency1]
      ComponentFile1]
     [[-ci ComponentIndex2] [-fw FrameWidth2] [-fh FrameHeight2]
      [-hf HorizontalFrequency2] [-vf VerticalFrequency2]
      ComponentFile1]
     ....

-JFIF puts a JFIF marker. Don't change component indices.
-a enables Reference DCT.
-b enables Lee DCT.
-d decoder enable.
-g put PGM headers on decode output files.
-[k predictortype] enables lossless mode.
-q specifies quantization factor; -ql specifies can be long.
-n enables non-interleaved mode.
-[t pointtransform] is the number of bits for the PT shift.
-o set a base name for decode output files.
-O enables the Command Interpreter.
-p specifies precision.
-y run in robust mode against errors (cannot be used with DNL).
-z uses default Huffman tables.
```


## Metadata
- **Skill**: not generated
