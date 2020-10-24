# README (./utc2nwislocal/TREE.md)

***
***

This file contains a plain-text representation of the directory structure of the **utc2nwislocal** repository and specifically the files being tracked. The tree was constructed using the `git tree` function that can be created for global access across repositories by the following command and stream editing. In the example, the tree has been redirected to `TREE.txt` and that tree inserted back into this `TREE.md` file. Separate processing results in the `TREE.pdf` file shown also in this directory though the PDF could have file-depth limitations because of excessive nodes for the means of typesetting.

```
git config --global alias.tree '! git ls-tree --full-name --name-only -t -r HEAD | sed -e "s/[^-][^\/]*\//   |/g" -e "s/|\([^ ]\)/|-- \1/"'

git tree > TREE.txt
```

***

```
.Rbuildignore
.gitignore
CONTRIBUTING.md
DESCRIPTION
DISCLAIMER.md
LICENSE.md
NAMESPACE
NEWS
R/
   |-- sysdata.rda
   |-- utc2nwislocal.R
   |-- zzz.R
README.md
SUMMARY.txt
TREE.md
TREE.pdf
code.json
inst/
   |-- CITATION
   |-- INSTALL_HELP.md
   |-- README.md
   |-- USGSapproval20200321.pdf
   |-- doc/
   |   |-- NWIStzCodes.txt
   |   |-- NWIStzCodes.xlsx
   |   |-- README.md
   |   |-- UserManual.pdf
   |   |-- buildSYSDATA(R).txt
   |-- www/
   |   |-- README.md
   |   |-- avatar.png
   |   |-- standard_time_zones_of_the_world.jpg
   |   |-- standard_time_zones_of_the_world.pdf
   |   |-- step1_src_utc2nwislocal_install.png
   |   |-- step2_src_utc2nwislocal_install.png
   |   |-- step3_src_utc2nwislocal_install.png
man/
   |-- nwislocal2utc_offset_hours.Rd
   |-- nwislocal2utc_offset_seconds.Rd
   |-- utc2nwislocal.Rd
   |-- utc_offset_hours2nwislocal.Rd
```
