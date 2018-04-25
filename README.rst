Domain-specific languages to Manycore and GPU: Building High-Performance Tools with Python
==========================================================================================

A tutorial on Domain-Specific Languages
---------------------------------------

This tutorial teaches you:

* how to **define** mathematically-oriented **domain-specific languages** ("DSLs") in
  Python

* how to build **transformations** for your DSLs to take them from **abstraction** to
  **implementation**

* how to generate highly efficient code from your domain-specific language

* how to use **just-in-time compilation** with OpenCL from Python to **execute
  generated code**

* a few existing **design studies** and **use cases** for domain-specific languages

* how to use loopy to generate **highly efficient code** to work with **array data**
  targeting **heterogeneous processor architectures** (CPUs/GPUs)

The tutorial also includes a brief introductory section to familiarize you with
the Python and numpy syntax.

This material is an updated version of a
`tutorial <http://sc15.supercomputing.org/schedule/event_detail-evid=tut174.html>`_ I
presented at `Supercomputing '15 <http://sc15.supercomputing.org>`_ in Austin.

Virtual machine image
---------------------

A virtual machine image is available that has all the necessary tools
installed, to allow for easy experimentation. Follow these instructions
to get started:

1. Download a version of VirtualBox suitable for your system and install it:

   https://www.virtualbox.org/wiki/Downloads

2. Download the machine image itself:

   http://andreask.cs.illinois.edu/tmp/dsl-tutorial.ova

3. (Optionally) Check whether the image downloaded correctly using the
   md5sum command line tool (Linux/OS X). On Windows, use this
   tool:

   http://www.pc-tools.net/win32/md5sums/

   Compare the computed checksum with the following value:
   6aa97e046293f8811d1749ab046f7f61

   Only proceed once the two match. If they don't, delete the file and
   retry the download.

4. Open VirtualBox, click "File > Import Appliance", select the
   downloaded image and just click "Next" a few times.  Once imported,
   double-click on the virtual machine to make sure it starts. After a
   little while, you should see a simple desktop environment.

5. Once all these steps complete successfully, congratulations! You are
   good to go. I'm looking forward to seeing you at the tutorial.

6. Double-click the "Terminal" symbol on the desktop and enter::

      curl -L https://bit.ly/sc15-dsl | bash

   This will download these materials onto the virtual machine and put them
   into a subdirectory called ``sc15-tutorial-materials``. Next, type::

       ipython3 notebook

   to launch a browser-based interface and get started.

Software tools
--------------

The tutorial demonstrates the use of the following pieces of software:

Core packages:

*   Python: https://www.python.org
*   numpy: https://www.numpy.org
*   pymbolic: https://github.com/inducer/pymbolic
*   PyOpenCL: https://github.com/pyopencl/pyopencl
*   loopy: https://github.com/inducer/loopy

Supporting packages:

*   matplotlib: http://www.matplotlib.org
*   mako: http://www.makotemplates.org
*   cgen: https://github.com/inducer/cgen

All open-source under MIT/BSD licenses.

License
-------

Copyright 2015 Andreas Kloeckner

Materials are available for use under a Creative Commons CC-BY license.  See
included file ``LICENSE`` for details.  (I.e. by and large: retain authorship
information, and otherwise do what you want)
