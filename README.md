# iibtoolkit
IBM Integration Bus v9 Toolkit with Healthcare Pack installed in a docker container.

The version of eclipse with all of the IIB plugins in 3.6.2.  This is pretty old by today's standards.  IIB won't even run successfully on CentOS 7.  So this is my attempt at creating a container that holds this tooling.

1.  CentOS 6 Base
2.  IIB Toolkit
3.  Updated to v9.0.0.4
4.  Healthcare Connectivity Pack v3.0.0.1
5.  XulRunner 1.9.2.19

# TODO:
Update the JDK of the toolkit to the latest GA version of IBM Java.

# Pre-requisites
Most of this is not freely available software from the web.  IIB v10 does have a completely free (as in beer) version available for download.  AFAIK, version 9 is no longer available.  Get the binaries from Passport Avantage Online.

The below install files should be in sub-directories under your docker build folder.

1. We need an extracted x86_64 linux binaries of the actual toolkit.  For my source, it can from the whole shebang (Websphere MQ, MQSI, IIB Toolkit and IIB Explorer)  You want the Intergration_Toolkit folder.
2. We also need the Healthcare Connectivity Pack v3.0.0.1 -- that will install without a previous version of the pack installed.  In otherwords; it can't just be the fixpack.  Unzip it to a folder called hcp.
3. XulRunner 1.9.2.19 -- wget https://ftp.mozilla.org/pub/xulrunner/releases/1.9.2.19/runtimes/xulrunner-1.9.2.19.en-US.linux-i686.tar.bz2.  Untar/Uncompress it in a folder called xulrunner.

You should have the following subfolders in your build directory:

Integration_Toolkit
hcp
xulrunner

and you should have Dockerfile in the build folder as well.

Edit the Dockerfile -- replace it with your user's UID and GID.

Then you execute docker build --rm -t iibtoolkit .
It'll grind awhile.  Also it'll be almost 6 gigs when it's done.

To run the toolkit, get the script.
---
This does not fully work yet.  There are still some kinks.
Basically whenever a message flow or DFDL is editted, the editor freezes.
I'm not sure why...   I'll detail the issues from the workspace logs later.
