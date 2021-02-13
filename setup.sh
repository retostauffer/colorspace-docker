#!/bin/bash

# Installing specific R version from tarball
# Installing R version 4.0.3 'focal fossa' (must match
# the underlying Ubuntu version; see Dockerfile).
BASEURL="https://cran.r-project.org/bin/linux/ubuntu/focal-cran40"
RCORE="r-base-core_4.0.3-1.2004.0_amd64.deb"
RBASE="r-base_4.0.3-1.2004.0_all.deb"

# colorspace SVN revision to install
REVISION=583

SHINYSERVER="https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.16.958-amd64.deb"

# Installing R
(cd /tmp && \
    wget ${BASEURL}/${RCORE} && \
    wget ${BASEURL}/${RBASE} && \
    dpkg --install ${RCORE} && \   # Install core
    apt-get install -f -y && \     # --fix-broken: install dependencies
    dpkg --install ${RBASE} && \   # Install base
    apt-get install -f -y)         # --fix-broken: install dependencies

# shiny requires to be installed before installing shiny-server.
# In addition, install shinyjs/rmarkdown required to run the apps.
R -e "install.packages('shiny', repos='https://cran.rstudio.com/')"
R -e "install.packages('shinyjs', repos='https://cran.rstudio.com/')"
R -e "install.packages('rmarkdown', repos='https://cran.rstudio.com/')"

# Installing shiny server
(apt-get install gdebi-core -y && \
    wget $SHINYSERVER && \
    SHINYSERVER=`basename $SHINYSERVER` && \
    gdebi -n $SHINYSERVER)

# Installing colorspace
apt-get install -y subversion
(cd opt/local &&
    svn checkout svn://r-forge.r-project.org/svnroot/colorspace/ -r${REVISION} &&
    R CMD INSTALL colorspace)


