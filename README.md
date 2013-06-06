orm4es is an orm tool for elasticsearch. It is very simple and easy to use.
This tool generate java bean of index mapping.
you can use the bean to search.
the main method of the bean show how to use it.

step 1
	svn install
step 2
	java -jar orm4es-0.0.1-SNAPSHOT.jar -h

usage: orm4es [-c <arg>] [-C <arg>] [-d <arg>] [-H <arg>]
       [-h] [-i <arg>] [-P <arg>] [-p <arg>]
example: java -jar transfer.jar -H 192.168.*.* -p 9300 -n
Product -i product
 -c,--class <arg>       class name,use index name if not
                        set.
 -C,--cluster <arg>     cluster name,default is
                        "elasticsearch"
 -d,--directory <arg>   file directory,default is c:\
 -H,--host <arg>        hostname or ip of es host
 -h,--help              get help infomation
 -i,--index <arg>       index name
 -P,--package <arg>     package.
 -p,--port <arg>        es port,default 9300.
this is a orm tool for es.
=============================================
orm for es index mapping.code gen

shenbaise1001@126.com
