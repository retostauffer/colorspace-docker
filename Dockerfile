
FROM ubuntu:20.04
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY .Rprofile /root/
#COPY shiny-server.service /usr/lib/systemd/system/
COPY setup.sh /setup.sh
COPY cleanup.sh /cleanup.sh
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
COPY script.sh /script.sh

# Installation; see setup.sh script for details
# wget: Download packages (R, shiny-server)
# make: For installing debian packages
# gcc/gfortran: to compile/install R packages
RUN apt-get update
RUN apt-get install -y vim wget make
RUN apt-get install -y gcc g++ gfortran
RUN apt-get install -y logrotate
#RUN /cleanup.sh

# Default port for shiny-server
EXPOSE 3838

# Starting shiny server
CMD ["/opt/shiny-server/bin/shiny-server"]
