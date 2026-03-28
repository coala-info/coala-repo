Installation Instructions for Consan
------------------------------------
tar -xvfz consan-1.0.tar.gz
cd consan-1.0
make
make install
Things to note:
---------------
\*) Assumes Ian Holmes' dpswalign program (from his Dart package) is available
in your path. Alternatively you can specify the location for dpswalign in
the header src/consan.h (DARTLOCATION). Obtain Holmes' DART pacakge from
http://
\*) The interface with dpswalign produces temporary files into src/tmp/. There
is a very poor mechanism for determining the filename. (Consequently, it is
not recommended to run consan multiple times simultaneously on the same machine.
Hence, when we utilized the software on a cluster, we set the SCRATCH path to
the local scratch directory for each node. See src/consan.h.