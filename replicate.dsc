#Version 1.1a

%%logfile = @datetime(mm-dd-yyyy-hh-nn).log

list create,7
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Replicator Process Started"
list savefile,7,%%logfile

list create,5
list loadfile,5,@path(%0)authkey.txt
%%key = @next(5)
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Using Auth Key - "%%key
list savefile,7,%%logfile
list close,5


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
%%url = "http://ui.slcsecurity.com/events/nids/snort/download"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Loaded Internet Connection Library"
list savefile,7,%%logfile
INTERNET HTTP,CREATE,1
INTERNET HTTP,HEADER,1,%%key
INTERNET HTTP,THREADS,1,OFF
INTERNET HTTP,PROTOCOL,1,1
INTERNET HTTP,USERAGENT,1,"SLC Replicator Version 1.1a/Windows XPlatorm"
list add,7,@datetime(mm-dd-yyyy hh:nn:ss)":Downloading "%%url
list savefile,7,%%logfile
INTERNET HTTP,DOWNLOAD,1,%%url,@path(%0)Feed\snort.rules
INTERNET HTTP,DESTROY,1
#End Download Snort Rules#


#Download Suricata Rules#
%%url = "http://ui.slcsecurity.com/events/nids/suricata/download"
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
%%url = "http://ui.slcsecurity.com/events/csv/download/"
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
