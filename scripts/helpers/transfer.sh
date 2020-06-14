#
# Defines transfer alias and provides easy command line file and folder sharing.
#
# Authors:
#   Remco Verhoef <remco@dutchcoders.io>
# Don’t Panic! transfer.sh will live on!
#   After running and supporting transfer.sh for 4 years on my own, I’m happy to announce we are partnering with Storj Labs to keep the project going. From day one, the transfer.sh code has been open source. Storj has a commitment to open source sustainability and reached out to help us find a way to keep our project alive. Stay tuned for updates on the partnership with Storj, but for now, please continue to enjoy the service! Blue skies, Remco Verhoef
# 
# Examples:
# - Upload multiple files at once:
#     $ curl -i -F filedata=@/tmp/hello.txt -F filedata=@/tmp/hello2.txt https://transfer.sh/
#     # Combining downloads as zip or tar archive
#     $ curl https://transfer.sh/(15HKz/hello.txt,15HKz/hello.txt).tar.gz
#     $ curl https://transfer.sh/(15HKz/hello.txt,15HKz/hello.txt).zip
# - Encrypt your files before the transfer
#     # Encrypt files with password using gpg
#     $ cat /tmp/hello.txt|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt
#     # Download and decrypt
#     $ curl https://transfer.sh/1lDau/test.txt|gpg -o- > /tmp/hello.txt
# - Scan for malware
#     # Scan for malware or viruses using Clamav
#     $ wget http://www.eicar.org/download/eicar.com
#     $ curl -X PUT --upload-file ./eicar.com https://transfer.sh/eicar.com/scan
#     # Upload malware to VirusTotal, get a permalink in return
#     $ curl -X PUT --upload-file nhgbhhj https://transfer.sh/test.txt/virustotal
# - Backup mysql database, encrypt and transfer
#     # Backup, encrypt and transfer
#     $ mysqldump --all-databases|gzip|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt
# - Send email with transfer link (uses alias)
#     # Transfer and send email with link (uses alias)
#     $ transfer /tmp/hello.txt | mail -s "Hello World" user@yourmaildomain.com
# - Using Keybase.io
#     # Import keys from keybase
#     $ keybase track [them] # Encrypt for recipient(s)
#     $ cat somebackupfile.tar.gz | keybase encrypt [them] | curl --upload-file '-' https://transfer.sh/test.txt # Decrypt
#     $ curl https://transfer.sh/sqUFi/test.md |keybase decrypt
# - wget uploads also supported
#     # wget
#     $ wget --method PUT --body-file=/tmp/file.tar https://transfer.sh/file.tar -O - -nv
# - Transfer pound logs
#     # grep syslog for pound and transfer
#     $ cat /var/log/syslog|grep pound|curl --upload-file - https://transfer.sh/pound.log
# - Upload a file using Powershell
#     # Upload using Powershell
#     PS H:\> invoke-webrequest -method put -infile .\file.txt https://transfer.sh/file.txt
# - Upload a file using HTTPie
#     # HTTPie
#     $ http https://transfer.sh/ -vv < /tmp/test.log



#   curl --version 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "Could not find curl."
  return 1
fi

transfer() { 
    # check arguments
    if [ $# -eq 0 ]; 
    then 
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    # get temporarily filename, output is written to this file show progress can be showed
    tmpfile=$( mktemp -t transferXXX )
    
    # upload stdin or file
    file=$1

    if tty -s; 
    then 
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 

        if [ ! -e $file ];
        then
            echo "File $file doesn't exists."
            return 1
        fi
        
        if [ -d $file ];
        then
            # zip directory and transfer
            zipfile=$( mktemp -t transferXXX.zip )
            cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
            curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
            rm -f $zipfile
        else
            # transfer file
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
        fi
    else 
        # transfer pipe
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
    fi
   
    # cat output link
    cat $tmpfile

    # cleanup
    rm -f $tmpfile
}

transfertomail() { 
    transfer $1 | mail -s "Transfer file - $1" temuraru@gmail.com 
}