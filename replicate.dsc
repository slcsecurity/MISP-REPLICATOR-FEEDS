#Version 1.2a
#Added support for specifying the server and moved settings to a Windows ini file to be more standardized

%%logfile = @datetime(mm-dd-yyyy-hh-nn).log

list create,7
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Replicator Process Started"
list savefile,7,%%logfile

inifile open,@path(%0)settings.ini
%A = @iniread(settings,key)
%B = @iniread(settings,server)
inifile close
if @null(%A)
info "Please edit the settings files and add your MISP API key"
stop
end
if @null(%B)
info "Please edit the settings files and enter your MISP server IP address to the server section"
stop
end

external string
#DEFINE FUNCTION,STRING
 
EXTERNAL VDSIPP.DLL,751118615004|ISP Toolz
#DEFINE COMMAND, INTERNET
#DEFINE FUNCTION, INTERNET
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Loaded Internet Connection Library"
list savefile,7,%%logfile
  
DIRECTORY CHANGE,@path(%0)


file delete,@path(%0)\Feed\*.*
wait 5



:getdata
#Download Snort Rules#
%%url = "http://"%B"/events/nids/snort/download"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Loaded Internet Connection Library"
list savefile,7,%%logfile
INTERNET HTTP,CREATE,1
INTERNET HTTP,HEADER,1,%A
INTERNET HTTP,THREADS,1,OFF
INTERNET HTTP,PROTOCOL,1,1
INTERNET HTTP,USERAGENT,1,"SLC Replicator Version 1.1a/Windows XPlatorm"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Downloading "%%url
list savefile,7,%%logfile
INTERNET HTTP,DOWNLOAD,1,%%url,@path(%0)Feed\snort.rules
INTERNET HTTP,DESTROY,1
#End Download Snort Rules#


#Download Suricata Rules#
%%url = "http://"%B"/events/nids/suricata/download"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Loaded Internet Connection Library"
list savefile,7,%%logfile
INTERNET HTTP,CREATE,1
INTERNET HTTP,HEADER,1,%%key
INTERNET HTTP,THREADS,1,OFF
INTERNET HTTP,PROTOCOL,1,1
INTERNET HTTP,USERAGENT,1,"SLC Replicator Version 1.1a/Windows XPlatorm"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Downloading "%%url
list savefile,7,%%logfile
INTERNET HTTP,DOWNLOAD,1,%%url,@path(%0)Feed\suricata.rules
INTERNET HTTP,DESTROY,1
#End Download Suricata Rules#

#Download CSV Rules#
%%url = "http://"%B"/events/csv/download/"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Loaded Internet Connection Library"
list savefile,7,%%logfile
INTERNET HTTP,CREATE,1
INTERNET HTTP,HEADER,1,%%key
INTERNET HTTP,THREADS,1,OFF
INTERNET HTTP,PROTOCOL,1,1
INTERNET HTTP,USERAGENT,1,"SLC Replicator Version 1.1a/Windows XPlatorm"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Downloading "%%url
list savefile,7,%%logfile
INTERNET HTTP,DOWNLOAD,1,%%url,@path(%0)Feed\rules.csv
INTERNET HTTP,DESTROY,1
#End Download CSV Rules#



:done
list savefile,7,%%logfile
stop
